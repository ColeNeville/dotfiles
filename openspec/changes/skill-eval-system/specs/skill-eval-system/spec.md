## ADDED Requirements

### Requirement: Skill evals directory structure

Each skill in `agent-skills/skills/` SHALL contain an `evals/` directory with an `evals.json` file defining test cases for that skill. A symlink `packages/extra-pi/.pi/agent/skills/` → `agent-skills/skills/` SHALL exist for pi harness compatibility.

#### Scenario: Evals directory exists per skill

- **WHEN** a skill is added to `agent-skills/skills/`
- **THEN** an `evals/` directory is created alongside the skill's `SKILL.md`

#### Scenario: Evals file contains test cases

- **WHEN** `evals/evals.json` is authored
- **THEN** it contains a `skill_name` field and an `evals` array with objects having `id`, `prompt`, and `expected_output` fields

### Requirement: Test case format

Each test case in `evals.json` SHALL include a unique `id`, a realistic `prompt`, an `expected_output` description, and an optional `assertions` array.

#### Scenario: Test case has required fields

- **WHEN** a test case is defined in `evals.json`
- **THEN** it contains `id` (integer), `prompt` (string), and `expected_output` (string)

#### Scenario: Test case has optional fields

- **WHEN** a test case includes `files` or `assertions`
- **THEN** `files` is an array of relative file paths and `assertions` is an array of verifiable statements

#### Scenario: Prompts vary in phrasing and formality

- **WHEN** test cases are written for a skill
- **THEN** at least one prompt is casual and at least one is precise, covering different user communication styles

### Requirement: Workspace layout for comparison

Eval runs SHALL use a shared workspace at `agent-skills/skill-eval/` with `iteration-N/` directories, each containing `with_skill/` and `without_skill/` subdirectories per test case.

#### Scenario: Iteration directory structure

- **WHEN** an eval iteration is run
- **THEN** the workspace contains `agent-skills/skill-eval/iteration-N/<eval-name>/with_skill/` and `agent-skills/skill-eval/iteration-N/<eval-name>/without_skill/` directories

#### Scenario: Each run directory contains outputs and metadata

- **WHEN** a run completes
- **THEN** its directory contains `outputs/` (produced files), `timing.json` (token count and duration), and `grading.json` (assertion results)

### Requirement: Assertion grading

Each test case output SHALL be graded by evaluating every assertion against the actual output, recording PASS or FAIL with concrete evidence.

#### Scenario: Grading records assertion results

- **WHEN** a test case is graded
- **THEN** `grading.json` contains `assertion_results[]` with `text`, `passed` (boolean), and `evidence` (string) for each assertion

#### Scenario: Grading includes summary statistics

- **WHEN** grading is complete
- **THEN** `grading.json` contains a `summary` object with `passed`, `failed`, `total`, and `pass_rate` fields

#### Scenario: PASS requires concrete evidence

- **WHEN** an assertion is marked as passed
- **THEN** the `evidence` field contains a specific, verifiable reference to the output (not a vague opinion)

### Requirement: Benchmark aggregation

After each iteration, aggregate statistics SHALL be computed and saved to `benchmark.json` with per-configuration metrics and a delta comparison.

#### Scenario: Benchmark includes per-configuration metrics

- **WHEN** an iteration completes
- **THEN** `benchmark.json` contains `run_summary.with_skill` and `run_summary.without_skill`, each with `pass_rate`, `time_seconds`, and `tokens` (each with `mean` and `stddev`)

#### Scenario: Benchmark includes delta comparison

- **WHEN** an iteration completes
- **THEN** `benchmark.json` contains a `delta` object showing the difference in `pass_rate`, `time_seconds`, and `tokens` between with-skill and without-skill configurations

### Requirement: Human feedback capture

Qualitative human review feedback SHALL be recorded per test case in `feedback.json`.

#### Scenario: Feedback is recorded per eval

- **WHEN** a human reviewer evaluates outputs
- **THEN** `feedback.json` maps each eval name to a specific, actionable feedback string (or empty string if no issues)

### Requirement: Eval run execution workflow

A single eval run SHALL be executed by providing four inputs to the agent: the skill path (or no skill for baseline), the test prompt, any input files, and the output directory. The instructions SHALL follow the template documented in the eval README.

#### Scenario: With-skill run uses skill path

- **WHEN** a with-skill eval run is executed
- **THEN** the instructions include `- Skill path: <path-to-skill>` and the agent follows only the skill's `SKILL.md`

#### Scenario: Without-skill run omits skill path

- **WHEN** a baseline eval run is executed
- **THEN** the instructions omit the skill path so the agent operates without the skill

#### Scenario: Instructions template is documented

- **WHEN** the eval README is authored
- **THEN** it includes the exact instruction template showing skill path, task, input files, and output directory fields

### Requirement: Eval system documentation

The eval system SHALL ship documentation explaining the workspace layout, iteration workflow, and how to create, grade, and review test cases.

#### Scenario: README explains workspace structure

- **WHEN** the eval README is read
- **THEN** it describes the `agent-skills/skill-eval/iteration-N/<eval-name>/{with_skill,without_skill}/` directory layout and what each file contains

#### Scenario: README documents the iteration loop

- **WHEN** the eval README is read
- **THEN** it describes the full iteration cycle: run with-skill, run without-skill, grade assertions, aggregate benchmarks, review feedback, iterate

#### Scenario: README documents test case authoring

- **WHEN** the eval README is read
- **THEN** it explains how to write `evals.json` test cases with prompts, expected outputs, and assertions

### Requirement: Helper scripts for eval orchestration

A `agent-skills/scripts/run-evals.sh` script SHALL provide subcommands for orchestrating the eval workflow.

#### Scenario: Script provides run subcommand

- **WHEN** the eval script is invoked with `run`
- **THEN** it spawns a with-skill and without-skill evaluation run, captures timing data, and saves outputs to the correct workspace directory

#### Scenario: Script provides aggregate subcommand

- **WHEN** the eval script is invoked with `aggregate`
- **THEN** it reads all `grading.json` files in the current iteration, computes pass rates, and writes `benchmark.json`

#### Scenario: Script provides clean subcommand

- **WHEN** the eval script is invoked with `clean`
- **THEN** it removes the current iteration directory to prepare for a fresh eval run
