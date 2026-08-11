---
name: agents-md
description: Create or update AGENTS.md files for coding agent documentation. Use when the user asks to create AGENTS.md, update AGENTS.md, maintain agent docs, or set up CLAUDE.md. Enforces research-backed best practices for minimal, high-signal agent documentation. Do NOT use for creating SKILL.md files or editing non-agent documentation.
---

# Maintaining AGENTS.md

AGENTS.md is the canonical agent-facing documentation. Keep it minimal — agents are capable and don't need hand-holding. Target under 60 lines; never exceed 100. Instruction-following quality degrades as document length increases.

## When to Use

Use this skill when the user asks to:

- Create a new `AGENTS.md` file
- Update or rewrite an existing `AGENTS.md`
- Maintain or audit agent documentation
- Set up `CLAUDE.md` or `GEMINI.md` symlinks

Do NOT use this skill for:

- Creating SKILL.md files — use `skill-creator` instead
- Writing README.md, CONTRIBUTING.md, or other human-facing docs
- General project documentation updates

## Before Writing

Analyze the project to understand what belongs in the file:

1. **Package manager** — Check for lock files (`pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`, `uv.lock`, `poetry.lock`)
2. **Linter/formatter configs** — Look for `.eslintrc`, `biome.json`, `ruff.toml`, `.prettierrc`, etc. (don't duplicate these in AGENTS.md)
3. **CI/build commands** — Check `Makefile`, `package.json` scripts, CI configs for canonical commands
4. **Monorepo indicators** — Check for `pnpm-workspace.yaml`, `nx.json`, Cargo workspace, or subdirectory `package.json` files
5. **Existing conventions** — Check for existing CONTRIBUTING.md, docs/, or README patterns

## Writing Rules

- **Headers + bullets** — No paragraphs; use concise bullet lists
- **Code blocks** — For commands and templates only
- **Reference, don't embed** — Point to existing docs: "See `CONTRIBUTING.md` for setup"
- **No filler** — No intros, conclusions, or pleasantries
- **Trust capabilities** — Omit obvious context the agent can figure out
- **Prefer file-scoped commands** — Per-file test/lint/typecheck over project-wide builds
- **Don't duplicate linters** — Code style lives in config files, not AGENTS.md

## Required Sections

### Package Manager

Which tool and key commands only:

```markdown
## Package Manager
Use **pnpm**: `pnpm install`, `pnpm dev`, `pnpm test`
```

### File-Scoped Commands

Per-file commands are faster and cheaper than full project builds. Include when available:

```markdown
## File-Scoped Commands
| Task | Command |
|------|---------|
| Typecheck | `pnpm tsc --noEmit path/to/file.ts` |
| Lint | `pnpm eslint path/to/file.ts` |
| Test | `pnpm jest path/to/file.test.ts` |
```

### Key Conventions

Project-specific patterns agents must follow. Keep brief — one line per convention.

## Optional Sections

Add only if truly needed:

- Commit attribution (agent identity conventions)
- API route patterns (show template, not explanation)
- CLI commands (table format)
- File naming conventions
- Project structure hints (point to critical files, flag legacy code)
- Monorepo overrides (subdirectory `AGENTS.md` files override root)

## Anti-Patterns

Omit these:

- "Welcome to..." or "This document explains..."
- "You should..." or "Remember to..."
- Linter/formatter rules already in config files
- Listing installed skills or plugins (agents discover these automatically)
- Full project-wide build commands when file-scoped alternatives exist
- Obvious instructions ("run tests", "write clean code")
- Explanations of why (just say what)
- Long prose paragraphs

## Example Structure

```markdown
# Agent Instructions

## Package Manager
Use **pnpm**: `pnpm install`, `pnpm dev`

## Commit Attribution
AI commits MUST include:

Co-Authored-By: (the agent's name and attribution byline)

## File-Scoped Commands
| Task | Command |
|------|---------|
| Typecheck | `pnpm tsc --noEmit path/to/file.ts` |
| Lint | `pnpm eslint path/to/file.ts` |
| Test | `pnpm jest path/to/file.test.ts` |

## Key Conventions
- Follow patterns in `src/api/routes/`
- Use conventional commits: `feat(scope): description`
```

## Gotchas

- **Line count matters** — every extra line dilutes signal; trim ruthlessly
- **Don't duplicate what linters already enforce** — AGENTS.md is for non-obvious rules only
- **Auto-generated AGENTS.md often hurts** — review and rewrite any agent-scaffolded draft; generic content the model already knows degrades performance
- **Symlink for compatibility** — if the project uses Claude Code, create `CLAUDE.md → AGENTS.md` symlink
- **Monorepo: use nested files** — place `AGENTS.md` in subdirectories for package-specific rules; closest file wins
