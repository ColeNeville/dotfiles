---
name: dotfiles-build
description: Install, stow, test, and lint dotfiles. Use when the user wants to install, stow, unstow, validate, or lint dotfiles configuration. Do NOT use for adding new packages or modifying shell scripts — use `dotfiles-workflow` for those tasks.
---

# Dotfiles Build, Test, and Validation

## Installation and Setup

```bash
# Full installation
./scripts/install.sh

# Setup after installation
dotfiles.sh setup

# Stow a specific package
./scripts/stow.sh <package-name>

# Stow all packages
./scripts/stow-all.sh

# Unstow a package
./scripts/unstow.sh <package-name>
```

## Testing/Validation

```bash
# Test script syntax (run for any changed shell script)
bash -n <script-path>

# Check if stow works without conflicts (dry run)
stow -n -t "$HOME" -S <package-name> -d packages/

# Verify XDG directory structure
ls -la ~/.local/bin ~/.local/share ~/.config

# Check git submodules status
git submodule status
```

## Linting

```bash
# Lua formatting (for Neovim configs)
stylua --check <neovim-config-path>

# Lua formatting (fix)
stylua <neovim-config-path>
```

**No automated tests exist** — validation is primarily manual verification of symlink creation and tool functionality.

## Gotchas

- **Dry-run first** — always test stow with `-n` before committing; conflicts will silently fail
- **Script syntax check is mandatory** — run `bash -n` on any changed script before stowing
- **Linting path is package-specific** — replace the hardcoded Neovim path with the actual config directory; don't assume a single package
