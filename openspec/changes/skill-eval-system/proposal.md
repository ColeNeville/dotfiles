## Why

Agent skills lack a structured evaluation system. Without evals, we can't reliably measure whether a skill improves output quality, costs fewer tokens, or handles edge cases better than no skill at all. This change introduces an eval-driven iteration workflow so skills can be tested, graded, and improved systematically.

## What Changes

- Create a top-level `agent-skills/` directory with a `skills/` subdirectory and move skills from `packages/extra-pi/.pi/agent/skills/` into it
- Symlink `packages/extra-pi/.pi/agent/skills/` → `agent-skills/skills/` for pi harness compatibility (points to the skills subdirectory, not the root, so `skill-eval/` is not detected as a skill)
- Add an `evals/` directory under each skill containing `evals.json` with test cases (prompts, expected outputs, assertions)
- Create a shared eval workspace (`agent-skills/skill-eval/`) with `iteration-N/` layout for comparing `with_skill` vs `without_skill` runs
- Provide helper scripts (`agent-skills/scripts/run-evals.sh`) for orchestrating eval runs, capturing timing data, and aggregating results
- Define grading output format (`grading.json`), benchmark aggregation (`benchmark.json`), and human feedback (`feedback.json`)
- Add sample test cases for all 5 skills (agents-md, commit, exa-fetch, exa-search, skill-creator)

## Capabilities

### New Capabilities

- `skill-eval-system`: Structured evaluation framework for agent skills, including test case definitions, assertion grading, benchmark aggregation, and iteration workflows

### Modified Capabilities
<!-- None — no existing specs define skill evaluation requirements -->

## Impact

- **Affected paths:** `packages/extra-pi/.pi/agent/skills/` (moved to `agent-skills/skills/`), `packages/extra-pi/.pi/agent/skills/` (now a symlink)
- **New paths:** `agent-skills/` (new top-level directory), `agent-skills/skills/` (skill directories), `agent-skills/skill-eval/` (eval workspace), `agent-skills/scripts/` (helper scripts)
- **New files:** eval JSON schemas, orchestration scripts, sample test cases, documentation
- **Symlink added:** `packages/extra-pi/.pi/agent/skills/` → `agent-skills/skills/`
- **No breaking changes** — symlink preserves existing skill paths for the pi harness
