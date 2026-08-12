#!/bin/bash
set -euo pipefail

# grade.sh — Automated grading for skill evals using pi.
# Usage: grade.sh <skill-dir> <iteration>
#
# Reads outputs from with_skill and without_skill runs, evaluates each
# assertion against the actual outputs, and writes grading.json files.

SKILL_DIR="${1:?Usage: grade.sh <skill-dir> <iteration>}"
ITERATION="${2:?Usage: grade.sh <skill-dir> <iteration>}"

# Resolve skill-eval workspace relative to this script
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_EVAL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/skill-eval"

# Validate skill directory
if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
	echo "Error: not a skill directory (no SKILL.md found): $SKILL_DIR" >&2
	exit 1
fi

# Get skill name from evals.json
EVALS_FILE="$SKILL_DIR/evals/evals.json"
skill_name=$(python3 -c "import json; print(json.load(open('$EVALS_FILE'))['skill_name'])")

# Validate iteration directory exists
iter_dir="$SKILL_EVAL_DIR/$skill_name/iteration-$ITERATION"
if [[ ! -d "$iter_dir" ]]; then
	echo "Error: no iteration found at $iter_dir" >&2
	exit 1
fi

echo "Grading evals for skill: $skill_name (iteration $ITERATION)"
echo ""

# Process each eval
for eval_dir in "$iter_dir"/eval-*/; do
	[[ -d "$eval_dir" ]] || continue
	eval_name=$(basename "$eval_dir")
	eval_id="${eval_name#eval-}"

	echo "--- $eval_name ---"

	# Extract prompt, expected_output, and assertions from evals.json
	eval_info=$(python3 -c "
import json
evals = json.load(open('$EVALS_FILE'))['evals']
for e in evals:
    if str(e['id']) == '$eval_id':
        print('PROMPT=' + e['prompt'].replace('\n', '\\n'))
        print('EXPECTED=' + e['expected_output'].replace('\n', '\\n'))
        for a in e.get('assertions', []):
            print('ASSERTION=' + a.replace('\n', '\\n'))
        break
")

	prompt=$(echo "$eval_info" | grep '^PROMPT=' | sed 's/^PROMPT=//')
	expected=$(echo "$eval_info" | grep '^EXPECTED=' | sed 's/^EXPECTED=//')
	assertions=$(echo "$eval_info" | grep '^ASSERTION=' | sed 's/^ASSERTION=//')

	# Build the grading prompt
	grade_prompt="You are evaluating an agent's output against specific criteria.

Prompt: $prompt

Expected output: $expected

Assertions to check (evaluate each independently):
$(echo "$assertions" | nl -w1 -s'. ')

---

Evaluate the with-skill run against these assertions. Consider what the skill-creator skill should produce.

Return ONLY valid JSON in this exact format:
{
  \"assertion_results\": [
    {\"text\": \"...\", \"passed\": true/false, \"evidence\": \"concrete reason\"}
  ],
  \"summary\": {\"passed\": N, \"failed\": M, \"total\": N+M, \"pass_rate\": 0.XX}
}

Do not include any explanation text outside the JSON."

	# Run with-skill grading
	pi --no-extensions --skill "$SKILL_DIR" --mode json -p "$grade_prompt" \
		>"$iter_dir/$eval_name/with_skill/outputs/raw_grade.json" 2>&1 || true

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
for line in open('$iter_dir/$eval_name/with_skill/outputs/raw_grade.json'):
    try:
        obj = json.loads(line)
        if is_delta(obj):
            continue
        print(json.dumps(obj, separators=(',', ':')))
    except json.JSONDecodeError:
        pass
" >"$iter_dir/$eval_name/with_skill/outputs/grade.json" 2>/dev/null
	rm -f "$iter_dir/$eval_name/with_skill/outputs/raw_grade.json"

	# Extract grading result from the last message
	grading_result=$(python3 -c "
import json, sys
for line in open('$iter_dir/$eval_name/with_skill/outputs/grade.json'):
    try:
        obj = json.loads(line)
        if obj.get('type') == 'agent_end':
            for msg in obj.get('messages', []):
                if msg.get('role') == 'assistant':
                    content = msg.get('content', [])
                    for c in content:
                        if c.get('type') == 'text':
                            text = c.get('text', '')
                            # Try to extract JSON from the response
                            start = text.find('{')
                            end = text.rfind('}') + 1
                            if start >= 0 and end > start:
                                print(text[start:end])
                            else:
                                print(text)
                            sys.exit(0)
    except json.JSONDecodeError:
        pass
print('{}')
" 2>/dev/null || echo "{}")

	# Validate and write grading.json
	python3 -c "
import json, sys
try:
    grading = json.loads('''$grading_result''')
    # Ensure required fields
    if 'assertion_results' not in grading:
        grading['assertion_results'] = []
    if 'summary' not in grading:
        grading['summary'] = {'passed': 0, 'failed': 0, 'total': 0, 'pass_rate': 0}
    json.dump(grading, open('$iter_dir/$eval_name/with_skill/grading.json', 'w'), indent=2)
    print(f'  with_skill: {grading[\"summary\"][\"pass_rate\"]} pass rate')
except Exception as e:
    print(f'  with_skill: failed to parse grading result ({e})')
    # Write empty grading as fallback
    json.dump({'assertion_results': [], 'summary': {'passed': 0, 'failed': 0, 'total': 0, 'pass_rate': 0}}, open('$iter_dir/$eval_name/with_skill/grading.json', 'w'), indent=2)
" 2>/dev/null

	# Run without-skill grading
	pi --no-extensions --mode json -p "$grade_prompt" \
		>"$iter_dir/$eval_name/without_skill/outputs/raw_grade.json" 2>&1 || true

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
for line in open('$iter_dir/$eval_name/without_skill/outputs/raw_grade.json'):
    try:
        obj = json.loads(line)
        if is_delta(obj):
            continue
        print(json.dumps(obj, separators=(',', ':')))
    except json.JSONDecodeError:
        pass
" >"$iter_dir/$eval_name/without_skill/outputs/grade.json" 2>/dev/null
	rm -f "$iter_dir/$eval_name/without_skill/outputs/raw_grade.json"

	grading_result=$(python3 -c "
import json, sys
for line in open('$iter_dir/$eval_name/without_skill/outputs/grade.json'):
    try:
        obj = json.loads(line)
        if obj.get('type') == 'agent_end':
            for msg in obj.get('messages', []):
                if msg.get('role') == 'assistant':
                    content = msg.get('content', [])
                    for c in content:
                        if c.get('type') == 'text':
                            text = c.get('text', '')
                            start = text.find('{')
                            end = text.rfind('}') + 1
                            if start >= 0 and end > start:
                                print(text[start:end])
                            else:
                                print(text)
                            sys.exit(0)
    except json.JSONDecodeError:
        pass
print('{}')
" 2>/dev/null || echo "{}")

	python3 -c "
import json, sys
try:
    grading = json.loads('''$grading_result''')
    if 'assertion_results' not in grading:
        grading['assertion_results'] = []
    if 'summary' not in grading:
        grading['summary'] = {'passed': 0, 'failed': 0, 'total': 0, 'pass_rate': 0}
    json.dump(grading, open('$iter_dir/$eval_name/without_skill/grading.json', 'w'), indent=2)
    print(f'  without_skill: {grading[\"summary\"][\"pass_rate\"]} pass rate')
except Exception as e:
    print(f'  without_skill: failed to parse grading result ({e})')
    json.dump({'assertion_results': [], 'summary': {'passed': 0, 'failed': 0, 'total': 0, 'pass_rate': 0}}, open('$iter_dir/$eval_name/without_skill/grading.json', 'w'), indent=2)
" 2>/dev/null

	echo ""
done

echo "Grading complete."
