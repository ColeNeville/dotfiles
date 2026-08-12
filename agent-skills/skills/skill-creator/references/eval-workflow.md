# Skill Eval System

Structured evaluation framework for agent skills. Test whether a skill improves output quality, reduces token usage, or handles edge cases better than no skill at all.

## Workspace Structure

```
agent-skills/skill-eval/
├── <skill-name>/                    ← one dir per skill
│   ├── iteration-1/                 ← each pass through the eval loop
│   │   ├── eval-1/                  ← one directory per test case
│   │   │   ├── with_skill/          ← run with the skill
│   │   │   │   ├── outputs/         ← files produced by the run
│   │   │   │   │   └── output.json  ← filtered agent output
│   │   │   │   ├── timing.json      ← tokens and duration
│   │   │   │   └── grading.json     ← assertion results
│   │   │   └── without_skill/       ← baseline run (no skill)
│   │   │       ├── outputs/
│   │   │       │   └── output.json
│   │   │       ├── timing.json
│   │   │       └── grading.json
│   │   ├── eval-2/
│   │   │   └── ...
│   │   └── benchmark.json           ← aggregated statistics
│   └── ...
```

## Iteration Workflow

1. **Run** — Execute each test case twice: once with the skill, once without. Save outputs to `iteration-N/`.
2. **Grade** — Automated grading via pi evaluates each assertion against the actual outputs. Record PASS/FAIL with evidence in `grading.json`.
3. **Review** — Verify the agent's grading results. Adjust if needed.
4. **Aggregate** — Run `eval-aggregate.sh <skill-name> <iteration>` to compute pass rates and write `benchmark.json`.
5. **Iterate** — If the skill needs improvement, update the `SKILL.md`, bump the iteration number, and repeat.

## Authoring Test Cases

Test cases live in `agent-skills/skills/<skill>/evals/evals.json`. Each test case has:

- **id** (integer) — unique identifier
- **prompt** (string) — a realistic user message
- **expected_output** (string) — human-readable description of success
- **files** (array, optional) — input files the skill needs
- **assertions** (array, optional) — verifiable statements about the output

### Tips

- Start with 2-3 test cases per skill. Expand after the first round of results.
- Vary phrasing: include both casual ("hey can you do x") and precise ("do x at path y") prompts.
- Cover edge cases: malformed input, unusual requests, ambiguous instructions.
- Write assertions that are specific and observable, not vague ("the output is good") or brittle ("uses exactly the phrase X").

## Running an Eval

### Using the script

```bash
# Run and grade all evals for a skill
./agent-skills/skills/<skill>/scripts/eval.sh <skill-dir> [iteration]

# Aggregate results for a skill's iteration
./agent-skills/scripts/eval-aggregate.sh <skill-name> <iteration>
```

## Automated Grading

The `grade.sh` script uses pi to evaluate outputs against assertions:

1. Reads the prompt, expected output, and assertions from `evals.json`
2. Invokes pi with the skill (for with-skill) and without (for baseline)
3. Evaluates each assertion against the actual output
4. Writes `grading.json` with PASS/FAIL results and evidence

### Grading Output

```json
{
  "assertion_results": [
    {
      "text": "The output includes X",
      "passed": true,
      "evidence": "Found X in the output at line Y"
    }
  ],
  "summary": {
    "passed": 3,
    "failed": 1,
    "total": 4,
    "pass_rate": 0.75
  }
}
```

### Grading Principles

- Require concrete evidence for a PASS. Don't give the benefit of the doubt.
- Review the assertions themselves — are they too easy (always pass), too hard (always fail), or unverifiable?
- Reserve assertions for things that can be checked objectively.
- The agent grading is a first pass — always verify results before archiving.

## Benchmarking

After grading, aggregate with `eval-aggregate.sh`. The benchmark shows:

- **pass_rate** — what fraction of assertions passed (with vs. without skill)
- **time_seconds** — how long each run took
- **tokens** — token cost of each run
- **delta** — the difference between with-skill and without-skill

A skill that adds 13 seconds but improves pass rate by 50 percentage points is probably worth it. A skill that doubles token usage for a 2-point improvement might not be.
