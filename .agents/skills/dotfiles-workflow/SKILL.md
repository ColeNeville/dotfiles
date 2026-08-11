---
name: dotfiles-workflow
description: Common workflows for the dotfiles repo — adding packages, modifying scripts, and updating submodules. Use when the user is adding a new package, modifying shell scripts, or updating submodules. Do NOT use for installing, stowing, testing, or linting — use `dotfiles-build` for those tasks.
---

# Dotfiles Common Workflows

## Adding a New Package

1. Create `packages/<package-name>/` directory
2. Add configuration files mirroring home directory structure
3. Add setup script to `.local/bin/dotfiles/setup.d/` if needed
4. Test with `./scripts/stow.sh <package-name>`

## Modifying Shell Scripts

1. Edit the script
2. Validate syntax: `bash -n <script-path>`
3. Test manually by running the script
4. Commit with appropriate conventional commit message

## Updating Git Submodules

```bash
git submodule update --recursive --remote
git add .gitmodules <submodule-path>
git commit -m "chore(submodules): update to latest versions"
```

## Scoping Documentation Changes

When adding or modifying a package, always update relevant documentation:

- **README.md** — add new packages to the "Available Packages" list
- **AGENTS.md** — update patterns, conventions, or examples if the change introduces a new pattern
- **openspec/specs/** — create or update capability specs for new features (statement, not a task)

## Gotchas

- **Mirror home directory structure** — files in `packages/<name>/.config/` become `~/.config/`; get the structure wrong and symlinks break
- **Setup scripts need numbered prefixes** — use `01-`, `02-`, etc. in `.local/bin/dotfiles/setup.d/` for predictable execution order
- **Test stow before committing** — always run `./scripts/stow.sh <package-name>` to verify no conflicts before pushing changes
- **Don't mix package types** — `common/` configs apply everywhere; `os-linux/` and `os-macos/` are OS-specific; `host-*` is host-specific. Don't override common settings in host-specific packages without purpose.
