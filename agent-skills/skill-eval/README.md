# Skill Eval System

Structured evaluation framework for agent skills. Test whether a skill improves output quality, reduces token usage, or handles edge cases better than no skill at all.

## Workspace Structure

```
agent-skills/skill-eval/
├── iteration-1/                    ← each pass through the eval loop
│   ├── <eval-name>/                ← one directory per test case
│   │   ├── with_skill/             ← run with the skill
│   │   │   ├── outputs/            ← files produced by the run
│   │   │   ├── timing.json         ← tokens and duration
│   │   │   └── grading.json        ← assertion results
│   │   └── without_skill/          ← baseline run (no skill)
│   │       ├── outputs/
│   │       ├── timing.json
│   │       └── grading.json
│   └── benchmark.json              ← aggregated statistics
├── templates/                      ← JSON templates for grading, benchmarks, feedback
└── README.md                       ← this file
```

## Iteration Workflow

1. **Run** — Execute each test case twice: once with the skill, once without. Save outputs to `iteration-N/`.
2. **Grade** — Evaluate each assertion against the actual outputs. Record PASS/FAIL with evidence in `grading.json`.
3. **Aggregate** — Run `run-evals.sh aggregate` to compute pass rates and write `benchmark.json`.
4. **Review** — Read the actual outputs and grades. Record qualitative feedback in `feedback.json`.
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

### Using the instruction template

Each eval run starts with a clean context. Provide these four inputs to the agent:

```
Execute this task:
- Skill path: /path/to/agent-skills/skills/<skill>
- Task: <the test prompt from evals.json>
- Input files: <path to any input files, or none>
- Save outputs to: <output directory>
```

For the baseline (without skill), use the same prompt but omit the skill path.

### Using the script

```bash
# Run a single eval
./agent-skills/scripts/run-evals.sh run <skill-dir> <eval-id> <iteration> [output-dir]

# Aggregate results
./agent-skills/scripts/run-evals.sh aggregate <iteration>

# Clean up an iteration
./agent-skills/scripts/run-evals.sh clean <iteration>
```

## Grading

After each run, grade the outputs by evaluating assertions:

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

**Grading principles:**

- Require concrete evidence for a PASS. Don't give the benefit of the doubt.
- Review the assertions themselves — are they too easy (always pass), too hard (always fail), or unverifiable?
- Reserve assertions for things that can be checked objectively.

## Benchmarking

After grading all runs in an iteration, aggregate with `run-evals.sh aggregate`. The benchmark shows:

- **pass_rate** — what fraction of assertions passed (with vs. without skill)
- **time_seconds** — how long each run took
- **tokens** — token cost of each run
- **delta** — the difference between with-skill and without-skill

A skill that adds 13 seconds but improves pass rate by 50 percentage points is probably worth it. A skill that doubles token usage for a 2-point improvement might not be.
