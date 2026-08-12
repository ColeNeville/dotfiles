---
name: commit
description: Create conventional commit messages. Use when asked to commit changes. Accepts a description of what to commit, e.g. "changes from the session", "staged changes", or "changes relating to x". Do NOT use for non-conventional-commit workflows (e.g., merge commits, squash messages, or release tags).
---

# Conventional Commit Skill

Create conventional commits with well-structured messages.

## Commit Type

Use one of these base types:

| Type    | When to use                                                                                           |
| ------- | ----------------------------------------------------------------------------------------------------- |
| `feat`  | Slightly larger changes: adding new features or substantially updating an existing feature            |
| `fix`   | Bug fixes, but also small tweaks to existing features                                                 |
| `chore` | Tiny changes or non-code-based changes: documentation, tests, copy, dependencies, configuration, etc. |

Add an optional but meaningful scope in parentheses after the type, e.g. `feat(auth):`, `fix(api):`, `chore(deps):`. Omit the scope if it's not clear or not useful.

### Breaking Changes

If the commit introduces a breaking change, append a `!` before the colon — either after the type or after the scope:

- `feat!: add user authentication`
- `feat(auth)!: rewrite auth module`

## Commit Message Format

The commit message follows this structure:

```
<type>(<scope>): <subject>

<body>
```

### Subject line

- **Soft limit:** 50 characters
- **Hard limit:** 70 characters
- Use the imperative mood ("add" not "added")
- No period at the end

### Body

- A bulleted list of specific changes, more verbose than the subject
- Each item describes one distinct change
- **Maximum 5 items** — if there are more than 5 distinct changes, ask the user to describe a more limited commit

## Important

- **Do NOT use `--signoff`** — it adds a `Signed-off-by` trailer which is different from `Co-authored-by` and should not be included.

## Staging Files

- **Stage specific files only** — never use `git add -A` or `git add *`
- Identify the exact files that belong in the commit and stage them individually
- If unsure which files to stage, ask the user

## Workflow

1. Ask the user what from the working tree should be committed, e.g. "changes from the session", "staged changes", or "changes relating to x"
2. Stage only the specific files that belong in this commit
3. Inspect the staged changes to determine the type, scope, and content
4. Write a subject line within the 50/70 character limits
5. Write a body with up to 5 bullet points describing the changes
6. If there are more than 5 distinct changes, ask the user to narrow the scope before committing
7. Run `git commit -m "$(cat <<'EOF'
<type>(<scope>): <subject>

- bullet 1
- bullet 2
- bullet 3

Co-authored-by: Pi Coding Agent <pi.local>
EOF
)"`

The `Co-authored-by` trailer is always appended after the body, separated by a blank line.

## Gotchas

- **Never use `git add -A`** — always stage specific files to avoid committing unrelated changes
- **Subject line limits are strict** — 50-char soft limit, 70-char hard limit; the commit will still work if exceeded but follow the convention
- **Ask before committing** — always confirm what should be committed; don't assume the user wants everything staged
- **Maximum 5 body items** — if there are more distinct changes, ask the user to narrow the scope
- **This skill is for conventional commits only** — do not use for merge commits, squash messages, or release tags
