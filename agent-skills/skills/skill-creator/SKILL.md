---
name: skill-creator
description: Create, scaffold, edit, and validate agent skills following best practices. Use when the user wants to create a new skill, edit an existing skill's structure, validate a skill's frontmatter or layout, or learn skill authoring patterns. Not for editing SKILL.md content of other skills — that's a general editing task.
---

# Skill Creator

Create, scaffold, edit, and validate agent skills. This skill encodes best practices gathered from Anthropic, OpenAI, PostHog, Red Hat, and the Agent Skills specification.

## Quick Start

```bash
# Scaffold a new skill
./scripts/scaffold.sh <skill-name>

# Options
./scripts/scaffold.sh <skill-name> --no-scripts
./scripts/scaffold.sh <skill-name> --no-references

# Run evals for a skill
./scripts/eval.sh <skill-dir> [iteration]
```

## Skill Anatomy

A skill is a directory containing:

```
skill-name/
├── SKILL.md              # Required — entry point (under 500 lines)
├── scripts/              # Optional — executable logic (CLI-first)
├── references/           # Optional — detailed docs loaded on demand
└── assets/               # Optional — templates, images, data files
```

## Writing SKILL.md

### Frontmatter (YAML)

Required fields:

| Field         | Constraints                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `name`        | Lowercase letters, numbers, hyphens only. Max 64 chars. Must match dir name. |
| `description` | What it does + when to use it. Max 1024 chars. Third person. Specific.       |

Optional fields (supported by some harnesses):

- `allowed-tools` — tool allowlist
- `license` — SPDX identifier
- `compatibility` — runtime requirements
- `metadata` — author, version, generatedBy

### Body Structure

```markdown
# <Skill Name>

## Overview
One-paragraph purpose.

## When to Use
Specific triggers and use cases.

## Workflow
Step-by-step procedures.

## Gotchas
Common mistakes and corrections.

## References
Links to detailed files: `references/xxx.md`.
```

## Description Craft

Structure: `[What it does] + [When to use it] + [Key capabilities]`

**Good:**
> Transform CSV data into visual charts. Use when the user asks to visualize data, create charts from CSV/TSV files, or generate plots. Produces PNG images with configurable dimensions.

**Bad:**
> Helps with data visualization.

Include trigger phrases users would actually say. Add negative triggers to prevent over-firing:
> Do NOT use for database queries, API calls, or text formatting tasks.

## Progressive Disclosure

| Level | Content                                    | Loaded when?            |
|-------|--------------------------------------------|-------------------------|
| L1    | name + description                         | Always (system prompt)  |
| L2    | SKILL.md body                              | Skill is invoked        |
| L3    | references/, assets/                       | Referenced by L2        |

**Rules:**

- Keep SKILL.md under 500 lines
- Gate non-essential content in references/
- Reference files one level deep from SKILL.md
- Use forward slashes in paths

## CLI-First Design

Skills with non-trivial executable logic should ship a dedicated CLI script under `scripts/` rather than embedding code inline in SKILL.md.

**Choose the right shape:**

| Shape              | Use when                              | Logic lives in      |
|--------------------|---------------------------------------|---------------------|
| Script-backed      | Logic > 2 lines of shell              | `scripts/`          |
| Inline-shell       | One- or two-line commands             | SKILL.md itself     |
| Pure reference     | Templates, taxonomies, decision tables| SKILL.md itself     |

**CLI script conventions:**

- One script per skill, subcommands for operations
- JSON on stdout, errors on stderr
- Meaningful exit codes
- `--dry-run` where side effects are involved
- Use `set -euo pipefail` for bash scripts

## Implementation Patterns

| Pattern | Use when | Key structure |
| --------- | ---------- | --------------- |
| Sequential workflow | Multi-step process in fixed order | Step → tool call → expected output; include rollback |
| Multi-tool coordination | Workflow spans multiple tools | Organize by phase; validate before proceeding |
| Iterative refinement | Output improves with iteration | Draft → quality check → refinement loop |
| Context-aware selection | Same outcome, different tools by context | Decision tree → select → explain → fallback |
| Domain-specific intelligence | Specialized knowledge beyond tool access | Pre-check → execution → documentation |

## Testing

Test along three axes:

1. **Triggering** — Does the skill fire on relevant queries and not on unrelated ones? Ask the agent: "When would you use the `<name>` skill?" — it should quote your trigger phrases.
2. **Functional correctness** — Does it produce correct outputs consistently across 3–5 runs?
3. **Performance** — Compare tool calls, messages, and tokens with vs. without the skill. An effective skill reduces all three.

## Evals

Every skill MUST have an `evals/evals.json` file. When creating or updating a skill:

1. **Create or update `evals/evals.json`** with 2–3 test cases covering the skill's core capabilities. Include varied prompts (casual, precise, edge cases) and specific assertions.
2. **Run the evals** with `scripts/eval.sh <skill-dir>`:
   - Reads test cases from the skill's `evals/evals.json`
   - Spawns with-skill and without-skill runs into the shared workspace
   - Saves outputs, timing, and grading stubs to `iteration-N/`
3. **Grade outputs** — fill in `grading.json` for each eval with PASS/FAIL and concrete evidence
4. **Aggregate** — run `agent-skills/scripts/run-evals.sh aggregate N` to compare pass rates
5. **Iterate** — if pass rates are low or the skill adds cost without quality gains, refine the SKILL.md and rerun

See **references/eval-workflow.md** for the full eval workflow and instruction template.

## Gotchas

- **Description too vague** → Add specific trigger phrases users would say
- **Description too broad** → Add negative triggers; narrow scope
- **Instructions ignored** → Put critical instructions first; move detail to references/
- **SKILL.md too large** → Split into references/ files
- **Too many skills** → Prefer a small set of focused skills with rich references/ over many thin ones
- **Time-sensitive info** → Move to "old patterns" section or remove

## Reference Files

For detailed guidance, see:

- **references/authoring-guide.md** — Deep dive into description craft, scripting, and patterns
- **references/validation-checklist.md** — Pre-merge validation checklist
- **references/common-mistakes.md** — Real-world pitfalls and corrections
- **references/eval-workflow.md** — Eval system and iteration workflow
