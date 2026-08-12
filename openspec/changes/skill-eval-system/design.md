## Context

The repo has 5 agent skills (agents-md, commit, exa-fetch, exa-search, skill-creator) currently stored in `packages/extra-pi/.pi/agent/skills/` — a location that implies they belong to the extra-pi package rather than being first-class repo assets. There is no structured way to test whether they improve output quality, reduce token usage, or handle edge cases better than no skill at all. The [agentskills.io evaluation framework](https://agentskills.io/skill-creation/evaluating-skills) provides a proven pattern: test cases with assertions, with/without skill comparisons, grading, and benchmark aggregation.

## Goals / Non-Goals

**Goals:**

- Move skills to a top-level `agent-skills/` directory with a symlink from `packages/extra-pi/.pi/agent/skills/` for pi harness compatibility
- Define a reusable `evals/` directory structure per skill with `evals.json` test cases
- Establish a shared eval workspace (`agent-skills/skill-eval/`) with `iteration-N/` runs comparing `with_skill` vs `without_skill`
- Provide helper scripts (`agent-skills/scripts/run-evals.sh`) for run orchestration, timing capture, and result aggregation
- Define output formats: `grading.json`, `benchmark.json`, `feedback.json`
- Include sample test cases (2-3 per skill) covering varied prompts and edge cases

**Non-Goals:**

- Automated eval runner (this is a manual/semi-manual system; automation can come later)
- Modifying existing skill SKILL.md files (evals are additive)
- CI/CD integration (out of scope for this change)
- Per-skill workspace directories (shared workspace pattern keeps things simple)

## Decisions

### 1. Top-level `agent-skills/` directory with symlink

**Decision:** Move all skills from `packages/extra-pi/.pi/agent/skills/` to `agent-skills/skills/`. Create a symlink `packages/extra-pi/.pi/agent/skills/` → `agent-skills/skills/`.

**Rationale:** Skills are first-class repo assets, not extra-pi specifics. The symlink points to the `skills/` subdirectory (not the `agent-skills/` root) so sibling directories like `skill-eval/` and `scripts/` are not detected as skills by the pi harness.

### 2. Per-skill evals, shared workspace

**Decision:** Each skill gets its own `evals/evals.json`, but all runs go to a single shared workspace at `agent-skills/skill-eval/`.

**Rationale:** Keeps test cases co-located with the skill they evaluate (easy to find and update), but avoids duplicating workspace infrastructure per skill. The workspace lives as a sibling to `skills/` and `scripts/` inside `agent-skills/`.

### 3. Workspace layout with iteration directories

**Decision:** `agent-skills/skill-eval/iteration-N/<eval-name>/with_skill/` and `without_skill/` subdirectories, each containing `outputs/`, `timing.json`, and `grading.json`.

**Rationale:** Clean separation of iterations for comparison. Each eval gets its own directory so outputs don't collide. `timing.json` and `grading.json` are produced per run for aggregation.

### 4. Helper scripts location

**Decision:** Provide a single `agent-skills/scripts/run-evals.sh` script that orchestrates the eval loop (spawn runs, capture timing, aggregate benchmarks).

**Rationale:** The eval workflow involves repeating the same steps (run with skill, run without, capture timing, grade, aggregate). A script reduces friction and makes the iteration loop more practical. Scripts live alongside skills and workspace in `agent-skills/`. Start simple — one script with subcommands.

### 5. Grading format with evidence

**Decision:** `grading.json` uses `assertion_results[]` with `text`, `passed`, and `evidence` fields, plus a `summary` with pass counts and rate.

**Rationale:** Requires concrete evidence for each PASS/FAIL, preventing hand-wavy grading. The summary enables quick benchmark comparison.

## Risks / Trade-offs

| Risk | Mitigation |
|------|-----------|
| Evals are too vague to grade meaningfully | Start with 2-3 cases per skill; tighten assertions after first round of results |
| Manual grading is tedious | Grading script can use LLM-assisted evaluation for non-mechanical assertions |
| High token cost for with/without comparisons | Capture timing.json; benchmark delta shows if skill is worth the cost |
| Test cases become stale as skills evolve | Evals are co-located with skills; review them during skill updates |
