#!/bin/bash
set -euo pipefail

# eval-aggregate.sh — Aggregate grading results for a skill's iteration.
# Usage: eval-aggregate.sh <skill-name> <iteration>
#
# Reads grading.json files from with_skill and without_skill runs,
# computes pass rates, and writes benchmark.json.

SKILL_NAME="${1:?Usage: eval-aggregate.sh <skill-name> <iteration>}"
ITERATION="${2:?Usage: eval-aggregate.sh <skill-name> <iteration>}"

# Resolve skill-eval workspace
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_EVAL_DIR="$SCRIPT_DIR/skill-eval"

# Validate iteration directory exists
iter_dir="$SKILL_EVAL_DIR/$SKILL_NAME/iteration-$ITERATION"
if [[ ! -d "$iter_dir" ]]; then
	echo "Error: no iteration found at $iter_dir" >&2
	exit 1
fi

echo "Aggregating results for $SKILL_NAME (iteration $ITERATION)"

# Collect grading results using python3 for reliable JSON parsing
python3 -c "
import json, os, glob

iter_dir = '$iter_dir'
benchmark_file = os.path.join(iter_dir, 'benchmark.json')

with_pass = 0
with_total = 0
with_tokens = 0
without_pass = 0
without_total = 0
without_tokens = 0
with_count = 0
without_count = 0

for grading_path in sorted(glob.glob(os.path.join(iter_dir, 'eval-*/with_skill/grading.json'))):
    with_count += 1
    grading = json.load(open(grading_path))
    summary = grading.get('summary', {})
    with_pass += summary.get('passed', 0)
    with_total += summary.get('total', 0)

    timing_path = os.path.join(os.path.dirname(grading_path), 'timing.json')
    if os.path.exists(timing_path):
        with_tokens += json.load(open(timing_path)).get('total_tokens', 0)

for grading_path in sorted(glob.glob(os.path.join(iter_dir, 'eval-*/without_skill/grading.json'))):
    without_count += 1
    grading = json.load(open(grading_path))
    summary = grading.get('summary', {})
    without_pass += summary.get('passed', 0)
    without_total += summary.get('total', 0)

    timing_path = os.path.join(os.path.dirname(grading_path), 'timing.json')
    if os.path.exists(timing_path):
        without_tokens += json.load(open(timing_path)).get('total_tokens', 0)

with_rate = round(with_pass / max(with_total, 1), 4) if with_count > 0 else 0
without_rate = round(without_pass / max(without_total, 1), 4) if without_count > 0 else 0

benchmark = {
    'skill': '$SKILL_NAME',
    'iteration': $ITERATION,
    'run_summary': {
        'with_skill': {
            'pass_rate': {'mean': with_rate, 'stddev': 0},
            'time_seconds': {'mean': 0, 'stddev': 0},
            'tokens': {'mean': with_tokens, 'stddev': 0}
        },
        'without_skill': {
            'pass_rate': {'mean': without_rate, 'stddev': 0},
            'time_seconds': {'mean': 0, 'stddev': 0},
            'tokens': {'mean': without_tokens, 'stddev': 0}
        },
        'delta': {
            'pass_rate': round(with_rate - without_rate, 4),
            'time_seconds': 0,
            'tokens': with_tokens - without_tokens
        }
    }
}

with open(benchmark_file, 'w') as f:
    json.dump(benchmark, f, indent=2)

print(f'  With skill pass rate:  {with_rate}')
print(f'  Without skill pass rate: {without_rate}')
print(f'  Delta: {round(with_rate - without_rate, 4)}')
print(f'  Benchmark written: {benchmark_file}')
"
