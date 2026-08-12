## 0. Skill Migration

- [x] 0.1 Create `agent-skills/skills/` directory
- [x] 0.2 Move skills from `packages/extra-pi/.pi/agent/skills/` to `agent-skills/skills/`
- [x] 0.3 Create symlink `packages/extra-pi/.pi/agent/skills/` → `agent-skills/skills/`

## 1. Workspace Setup

- [x] 1.1 Create `agent-skills/skill-eval/` directory with `iteration-1/` stub
- [x] 1.2 Create `agent-skills/skill-eval/iteration-1/` with sample `eval-test-case/with_skill/` and `without_skill/` subdirectories, each containing `outputs/`, `timing.json`, and `grading.json` stubs

## 2. Per-Skill Eval Definitions

- [x] 2.1 Create `agent-skills/skills/agents-md/evals/evals.json` with 2-3 test cases for AGENTS.md creation/editing
- [x] 2.2 Create `agent-skills/skills/commit/evals/evals.json` with 2-3 test cases for conventional commit message generation
- [x] 2.3 Create `agent-skills/skills/exa-fetch/evals/evals.json` with 2-3 test cases for webpage content fetching
- [x] 2.4 Create `agent-skills/skills/exa-search/evals/evals.json` with 2-3 test cases for web search queries
- [x] 2.5 Create `agent-skills/skills/skill-creator/evals/evals.json` with 2-3 test cases for skill scaffolding/validation

## 3. Output Format Templates

- [x] 3.1 Create `agent-skills/skill-eval/templates/grading.json` with assertion_results array and summary object
- [x] 3.2 Create `agent-skills/skill-eval/templates/benchmark.json` with run_summary (with_skill, without_skill, delta) containing pass_rate, time_seconds, tokens with mean/stddev
- [x] 3.3 Create `agent-skills/skill-eval/templates/feedback.json` with eval-name-to-feedback mapping

## 4. Helper Scripts

- [x] 4.1 Create `agent-skills/scripts/run-evals.sh` with shebang and `set -euo pipefail`
- [x] 4.2 Implement `run` subcommand: spawns with-skill and without-skill runs, captures timing data, saves to workspace
- [x] 4.3 Implement `aggregate` subcommand: reads grading.json files, computes pass rates, writes benchmark.json
- [x] 4.4 Implement `clean` subcommand: removes current iteration directory
- [x] 4.5 Make `agent-skills/scripts/run-evals.sh` executable

## 5. Documentation

- [x] 5.1 Create `agent-skills/skill-eval/README.md` explaining the eval workflow, workspace structure, iteration loop, and how to author test cases
- [x] 5.2 Include the eval run instruction template in the README (skill path, task, input files, output directory)
- [x] 5.3 Create `.gitkeep` files in workspace directories that should be tracked
