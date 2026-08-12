#!/bin/bash
set -euo pipefail

# eval.sh — Run and grade evals for a specific skill using the skill-eval system.
# Usage: eval.sh <skill-dir> [iteration]
#
# Finds evals.json in the skill directory, then runs the eval loop:
#   1. Reads test cases from evals/evals.json
#   2. Spawns with-skill and without-skill runs via `pi --skill`
#   3. Captures timing and token data
#   4. Saves outputs to the skill-eval workspace
#   5. Runs automated grading via `grade.sh`

SKILL_DIR="${1:?Usage: eval.sh <skill-dir> [iteration]}"
ITERATION="${2:-1}"

# Resolve skill-eval workspace relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_EVAL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/skill-eval"

# Create a clean workspace so pi doesn't pick up project AGENTS.md or context files
WORKSPACE_DIR=$(mktemp -d)
trap 'rm -rf "$WORKSPACE_DIR"' EXIT

# Validate skill directory
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
	echo "Error: not a skill directory (no SKILL.md found): $SKILL_DIR" >&2
	exit 1
fi

# Validate evals.json exists
EVALS_FILE="$SKILL_DIR/evals/evals.json"
if [[ ! -f "$EVALS_FILE" ]]; then
	echo "Error: no evals/evals.json found in: $SKILL_DIR" >&2
	echo "Create evals/evals.json with test cases before running evals." >&2
	exit 1
fi

# Validate evals.json has content
eval_count=$(python3 -c "import json; print(len(json.load(open('$EVALS_FILE'))['evals']))")
if [[ "$eval_count" -eq 0 ]]; then
	echo "Error: evals.json has no test cases." >&2
	exit 1
fi

skill_name=$(python3 -c "import json; print(json.load(open('$EVALS_FILE'))['skill_name'])")

echo "Running evals for skill: $skill_name"
echo "  Evals: $EVALS_FILE ($eval_count test cases)"
echo "  Workspace: $SKILL_EVAL_DIR"
echo "  Iteration: $ITERATION"
echo ""

# Create per-skill iteration directory
skill_eval_dir="$SKILL_EVAL_DIR/$skill_name"
iter_dir="$skill_eval_dir/iteration-$ITERATION"
mkdir -p "$iter_dir"

# Run each eval
for i in $(seq 0 $((eval_count - 1))); do
	eval_id=$(python3 -c "import json; print(json.load(open('$EVALS_FILE'))['evals'][$i]['id'])")
	_prompt=$(python3 -c "import json; print(json.load(open('$EVALS_FILE'))['evals'][$i]['prompt'])")
	eval_dir="$iter_dir/eval-$eval_id"

	echo "--- eval-$eval_id ---"

	# Create directory structure
	with_dir="$eval_dir/with_skill"
	without_dir="$eval_dir/without_skill"
	mkdir -p "$with_dir/outputs" "$without_dir/outputs"

	# Run with-skill: pi --no-extensions --skill <path> --mode json -p <prompt>
	start_ms=$(date +%s%3N)
	pi --no-extensions --skill "$SKILL_DIR" --mode json -p "$_prompt" >"$with_dir/outputs/raw.json" 2>&1 || true
	end_ms=$(date +%s%3N)
	duration_ms=$((end_ms - start_ms))

	# Filter out streaming delta events to keep output readable
	python3 -c "
import json, sys
def is_delta(obj):
    t = obj.get('type', '')
    if t.endswith('_delta'):
        return True
    evt = obj.get('assistantMessageEvent', {})
    if evt.get('type', '').endswith('_delta'):
        return True
    return False
for line in open('$with_dir/outputs/raw.json'):
    try:
        obj = json.loads(line)
        if is_delta(obj):
            continue
        print(json.dumps(obj, separators=(',', ':')))
    except json.JSONDecodeError:
        pass
" >"$with_dir/outputs/output.json" 2>/dev/null
	rm -f "$with_dir/outputs/raw.json"

	# Extract totalTokens from the agent_end event (assistant message has usage, user does not)
	total_tokens=$(python3 -c "
import json, sys
for line in open('$with_dir/outputs/output.json'):
    try:
        obj = json.loads(line)
        if obj.get('type') == 'agent_end':
            for msg in obj.get('messages', []):
                usage = msg.get('usage', {})
                if usage and 'totalTokens' in usage:
                    print(usage['totalTokens'])
                    sys.exit(0)
    except json.JSONDecodeError:
        pass
print(0)
" 2>/dev/null || echo "0")
	[[ -z "$total_tokens" ]] && total_tokens=0

	cat >"$with_dir/timing.json" <<EOF
{
  "total_tokens": $total_tokens,
  "duration_ms": $duration_ms
}
EOF

	# Run without-skill: pi --no-extensions --mode json -p <prompt>
	start_ms=$(date +%s%3N)
	pi --no-extensions --mode json -p "$_prompt" >"$without_dir/outputs/raw.json" 2>&1 || true
	end_ms=$(date +%s%3N)
	duration_ms=$((end_ms - start_ms))

	# Filter out streaming delta events to keep output readable
	python3 -c "
import json, sys
def is_delta(obj):
    t = obj.get('type', '')
    if t.endswith('_delta'):
        return True
    evt = obj.get('assistantMessageEvent', {})
    if evt.get('type', '').endswith('_delta'):
        return True
    return False
for line in open('$without_dir/outputs/raw.json'):
    try:
        obj = json.loads(line)
        if is_delta(obj):
            continue
        print(json.dumps(obj, separators=(',', ':')))
    except json.JSONDecodeError:
        pass
" >"$without_dir/outputs/output.json" 2>/dev/null
	rm -f "$without_dir/outputs/raw.json"

	total_tokens=$(python3 -c "
import json, sys
for line in open('$without_dir/outputs/output.json'):
    try:
        obj = json.loads(line)
        if obj.get('type') == 'agent_end':
            for msg in obj.get('messages', []):
                usage = msg.get('usage', {})
                if usage and 'totalTokens' in usage:
                    print(usage['totalTokens'])
                    sys.exit(0)
    except json.JSONDecodeError:
        pass
print(0)
" 2>/dev/null || echo "0")
	[[ -z "$total_tokens" ]] && total_tokens=0

	cat >"$without_dir/timing.json" <<EOF
{
  "total_tokens": $total_tokens,
  "duration_ms": $duration_ms
}
EOF

	# Initialize empty grading files
	cat >"$with_dir/grading.json" <<'EOF'
{
  "assertion_results": [],
  "summary": {
    "passed": 0,
    "failed": 0,
    "total": 0,
    "pass_rate": 0
  }
}
EOF

	cat >"$without_dir/grading.json" <<'EOF'
{
  "assertion_results": [],
  "summary": {
    "passed": 0,
    "failed": 0,
    "total": 0,
    "pass_rate": 0
  }
}
EOF

	echo "  Saved to: $eval_dir"
	echo ""
done

# Run automated grading
"$SCRIPT_DIR/grade.sh" "$SKILL_DIR" "$ITERATION"

echo ""
echo "All evals complete. Results in: $iter_dir"
echo ""
echo "Next steps:"
echo "  1. Review graded outputs: $iter_dir/*/with_skill/grading.json"
echo "  2. Aggregate: $(dirname "$SCRIPT_DIR")/scripts/eval-aggregate.sh $skill_name $ITERATION"
echo "  3. Review: read outputs/ and grading.json, add feedback"
echo "  4. Iterate: update SKILL.md, bump iteration, and rerun"
