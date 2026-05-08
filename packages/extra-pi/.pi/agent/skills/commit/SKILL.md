---
name: commit
description: Create conventional commit messages. Use when asked to commit changes. Accepts a description of what to commit, e.g. "changes from the session", "staged changes", or "changes relating to x".
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
6. Run `git commit -m "subject" -m "body"`
7. If there are more than 5 distinct changes, ask the user to narrow the scope before committing
8. Always add a `Co-authored-by` trailer to every commit:
   ```
   Co-authored-by: Pi Coding Agent <pi.local>
   ```
   Append this after the body, separated by a blank line.
