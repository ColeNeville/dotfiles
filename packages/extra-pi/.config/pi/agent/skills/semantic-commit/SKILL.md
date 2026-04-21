---
name: semantic-commit
description: |
  Use this skill when asked to commit code. Creates semantic (conventional) commit messages
  for staged or working-tree changes, with a co-author attribution line crediting the
  pi coding agent and the LLM model used.
license: MIT
---

# Semantic Commit Skill

Creates git commits using [Conventional Commits](https://www.conventionalcommits.org/) format
and adds a `Co-authored-by` trailer so the source of the changes is credited.

## How It Works

1. Inspect staged and unstaged changes with `git diff --cached` and `git diff`.
2. Determine the commit type, optional scope, and a concise subject line.
3. Optionally add a body explaining _why_ the change was made (not just _what_).
4. Stage any unstaged working-tree files that belong in this commit.
5. Run `git commit` with the formatted message.
6. Append a `Co-authored-by` trailer to the commit message.

## Commit Type Reference

| Type       | Meaning                                                                 |
| ---------- | ----------------------------------------------------------------------- |
| `feat`     | A new feature                                                           |
| `fix`      | A bug fix                                                               |
| `docs`     | Documentation only changes                                              |
| `style`    | Code style changes (whitespace, formatting, semicolons, etc.) — no logic change |
| `refactor` | A code change that neither fixes a bug nor adds a feature               |
| `perf`     | A performance improvement                                               |
| `test`     | Adding missing tests or correcting existing tests                       |
| `build`    | Changes affecting build system, dependencies, or external modules       |
| `ci`       | CI configuration changes                                                |
| `chore`    | Other changes (tooling, configs, maintenance) that don't affect source  |

## Format

```
type(scope): description

* bullet point 1
* bullet point 2
* bullet point 3

Co-authored-by: pi-coding-agent <pi@agent.local> (model: <model-name>)
```

- **Type**: one of the values above, lowercase.
- **Scope** (optional): the module or file affected, e.g. `(bash)`, `(nvim)`, `(dotfiles.sh)`. Omit when changes span many areas.
- **Description**: imperative mood, present tense, no period at end. Soft limit 50 chars; hard limit 72 chars. E.g. `add semantic-commit skill`.
- **Body** (optional): use bullet points (`* `) to summarize key changes concisely. No full sentences — keep each bullet short and scannable.

## Co-author Line

Always append this exact footer:

```

Co-authored-by: pi-coding-agent <pi@agent.local> (model: <model-name>)
```

Replace `<model-name>` with the model currently in use for this session. You can find it by:

1. Checking `~/.config/pi/agent/settings.json` → `defaultModel`
2. Or reading the environment variable `PI_DEFAULT_MODEL` if set
3. Or inferring from context (the assistant is aware of its own model)

Examples:

```
Co-authored-by: pi-coding-agent <pi@agent.local> (model: qwen3.6-35b-a3b)
Co-authored-by: pi-coding-agent <pi@agent.local> (model: anthropic/claude-sonnet-4-20250514)
```

## Steps

1. **Gather changes**: Run `git diff --cached` for staged changes and `git diff` for unstaged. If only working-tree files need committing, stage them first with `git add`.
2. **Classify**: Pick the most appropriate type from the table above. If multiple types apply, choose the dominant one.
3. **Write message**: Compose using the format above — keep the subject under 50 chars (hard 72) and use bullet points for the body.
4. **Commit**: Run `git commit -m "..."` or `git commit -m "$(cat <<< "$message")"` to ensure proper formatting with the co-author footer.

## Examples

### Simple feature change
```bash
git add packages/extra-pi/.config/pi/agent/skills/semantic-commit/
git commit -m "feat(pi): add semantic-commit skill

* conventional commits with co-author trailer
* type/scope reference table included

Co-authored-by: pi-coding-agent <pi@agent.local> (model: qwen3.6-35b-a3b)"
```

### Bug fix with scope
```bash
git commit -m "fix(bash): guard empty array expansion under set -u

* replace ${ARRAY:-()} with conditional init
* add length check before \"${ARRAY[@]}\" expansion

Co-authored-by: pi-coding-agent <pi@agent.local> (model: anthropic/claude-sonnet-4-20250514)"
```

### Chore / housekeeping
```bash
git commit -m "chore(deps): update git submodules to latest

Co-authored-by: pi-coding-agent <pi@agent.local> (model: qwen3.6-35b-a3b)"
```

## Rules

- **Never** omit the `Co-authored-by` trailer — it is mandatory.
- Use imperative mood in the subject line ("add" not "added", "fix" not "fixed").
- Do not capitalize the first letter of the subject after the type prefix.
- No period at the end of the subject line.
- Soft limit 50 chars on the subject; hard limit 72 chars.
- Use bullet points (`* `) in the body, no full sentences — keep each line short and scannable.
- If there are no staged or unstaged changes, inform the user before committing.
