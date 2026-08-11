# Skill Authoring Guide

Deep dive into effective skill authoring, drawn from Anthropic, OpenAI, PostHog, Red Hat, and the Agent Skills specification.

## Table of Contents

- [Description Deep Dive](#description-deep-dive)
- [Scripting Patterns](#scripting-patterns)
- [Workflow Patterns](#workflow-patterns)
- [Context Budgeting](#context-budgeting)
- [Distribution & Portability](#distribution--portability)
- [Security Hygiene](#security-hygiene)

---

## Description Deep Dive

The description is the **load gate** — it decides whether the agent loads the full skill.

### Structure Formula

```text
[What it does] + [When to use it] + [Key capabilities]
```

### Writing Techniques

**Front-load the key use case** — descriptions may be truncated in large skill sets (agents use at most 2% of context window, or 8,000 chars, for the initial skills list).

**Include trigger phrases users would actually say:**
> "Generate a changelog from git commits" — matches queries like "write changelog", "summarize commits", "what changed"

**Add negative triggers to prevent over-firing:**
> "Do NOT use for commit message generation, code review, or branch management."

**Write in third person:**

- Good: "Processes Excel files and generates reports"
- Bad: "I can help you process Excel files"
- Bad: "You can use this to process Excel files"

### Examples

```yaml
# Good — specific triggers, negative constraints
description: >
  Generate release notes from git commit history and PR descriptions.
  Use when the user asks to create release notes, summarize changes,
  or generate changelogs. Parses conventional commits and groups by type.
  Do NOT use for commit message generation or code review.

# Good — tool-specific with clear scope
description: >
  Query PostHog analytics data using HogQL. Use when the user asks
  to analyze trends, run queries, or extract metrics from PostHog.
  Supports event tracking, funnel analysis, and retention queries.
  Do NOT use for feature flag management or experiment analysis.

# Bad — too vague
description: >
  Helps with analytics and data visualization tasks.
```

---

## Scripting Patterns

### When to Script vs. Use Instructions

| Use scripts when... | Use instructions when... |
| --------------------- | -------------------------- |
| Data fetching and formatting | Subjective analysis |
| Validation and sanitization | Advanced reasoning tasks |
| Deterministic computation | Too many edge cases to enumerate |
| Repeated mechanical operations | Guidance naturally splits into workflow + references |

**Hybrid approach (recommended):** scripts for the mechanical layer, SKILL.md for the reasoning layer. This can cut costs by ~26%.

### Bash Script Template

```bash
#!/bin/bash
set -euo pipefail

# Usage: script.sh <command> [args...]
# Commands: subcommand1, subcommand2

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> [options]

Commands:
  subcommand1  Description of subcommand1
  subcommand2  Description of subcommand2
  help         Show this help message

Options:
  --dry-run    Preview changes without applying
  --verbose    Enable verbose output
  --help       Show this help message
EOF
  exit 0
}

main() {
  local command="${1:-help}"
  shift || true

  case "$command" in
    subcommand1)
      subcommand1 "$@"
      ;;
    subcommand2)
      subcommand2 "$@"
      ;;
    help|--help|-h)
      usage
      ;;
    *)
      echo "Error: unknown command '$command'" >&2
      usage
      exit 1
      ;;
  esac
}

subcommand1() {
  local dry_run=false
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run) dry_run=true; shift ;;
      *) echo "Unknown option: $1" >&2; exit 1 ;;
    esac
  done
  # ... implementation
}

main "$@"
```

### Python Script Template

```python
#!/usr/bin/env python3
"""Short description of what this script does."""

import argparse
import json
import sys


def subcommand1(args):
    """Handle subcommand1."""
    if args.dry_run:
        print(json.dumps({"dry_run": True, "action": "subcommand1"}))
        return 0
    # ... implementation
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)

    # subcommand1
    p1 = subparsers.add_parser("subcommand1", help="Description of subcommand1")
    p1.add_argument("--dry-run", action="store_true", help="Preview without applying")

    args = parser.parse_args()

    try:
        sys.exit(subcommand1(args))
    except Exception as e:
        print(json.dumps({"error": str(e)}), file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
```

---

## Workflow Patterns

### Pattern 1: Sequential Workflow Orchestration

Multi-step process in fixed order.

```markdown
## Workflow

1. **Parse input** — Extract relevant data from user request
2. **Validate** — Check prerequisites and input format
3. **Execute** — Run the core operation
4. **Verify** — Confirm the output is correct
5. **Report** — Present results to the user
6. **Rollback** — If step N fails, undo steps 1 through N-1
```

### Pattern 2: Multi-Tool Coordination

Workflow spans multiple tools or services.

```markdown
## Workflow

Organize by phase. Validate before proceeding. Pass data explicitly between phases.

**Phase 1: Discovery**
- Use tool A to find available resources
- Filter results by criteria

**Phase 2: Selection**
- Present options to user
- Wait for confirmation

**Phase 3: Execution**
- Apply changes using tool B
- Report success/failure per item
```

### Pattern 3: Iterative Refinement

Output improves with iteration.

```markdown
## Workflow

1. Draft initial output
2. Quality check against criteria
3. If quality < threshold: refine and repeat (max 3 iterations)
4. Exit condition: quality threshold met or max iterations reached
```

---

## Context Budgeting

### The Shared Context Budget

```text
context window = system prompt + all skill descriptions + conversation history + loaded skill + user request
```

### Rules of Thumb

| Component | Budget | Notes |
| ----------- | -------- | ------- |
| L1 (all descriptions) | 2% of context (8K chars) | May be truncated if too many skills |
| L2 (SKILL.md body) | Under 500 lines | Performance degrades beyond this |
| L3 (references/) | As needed | Biggest token sink if not gated |

### Optimization Strategies

1. **Default assumption: the agent is already smart.** Only include context it doesn't already have.
2. **Challenge each piece of information:** Does the agent really need this explanation?
3. **Write instructions as a delta from baseline model behavior:** Only team conventions, domain rules, and edge cases the model would otherwise get wrong.
4. **Use references/ for everything non-essential:** Schemas, examples, full API docs, extensive reference material.
5. **Bundle comprehensive resources:** Include complete docs — no context penalty until accessed.

---

## Distribution & Portability

### Skill Discovery Locations

Different harnesses scan different directories:

| Harness | Locations |
| --------- | ----------- |
| Claude Code | `.agents/skills/`, `.claude/skills/` |
| OpenAI Codex | `.agents/skills/` (from cwd up to repo root) |
| Custom | Any path in config |

### Portability Tips

1. **Keep logic scripts separate from harness-specific prompts and configuration.**
2. **Hardcode sequential steps** rather than relying on the agent to chain them.
3. **Test across harnesses** if distributing widely.
4. **Use forward slashes** in all file paths.

### Versioning

- Script arguments, plugin source paths, and SKILL.md structures should not change in patch versions.
- Skill directories live in Git — changes go through pull requests.
- Rollback capability matters in production.

---

## Security Hygiene

1. **Manage credentials via environment variables**, never hardcode.
2. **Validate all inputs** to prevent injection.
3. **Require human confirmation** for state-altering actions.
4. **Instruct models to ignore embedded commands** from external data.
5. **Install skills only from trusted sources.** Audit before use.
6. **When using networking**, keep allowlists strict and assume tool output is untrusted.

---

## Evaluation

### Building Test Cases

A good test case has three components:

1. A realistic, context-rich user prompt
2. A clear description of expected output
3. Any input files needed for execution

Start with 2–3 varied prompts covering:

- Casual language ("can you make me a changelog")
- Precise language ("generate a changelog from v1.0.0 to v2.0.0")
- Boundary conditions (empty input, malformed data)

### Regression Testing

- Configure CI to run evaluations before merging updates
- Compare across token expenditure, directive adherence, and functional correctness
- Block merges based on regression limits
