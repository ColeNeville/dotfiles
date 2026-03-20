# Agent Guidelines for Dotfiles Repository

This document provides guidelines for AI coding agents working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository using GNU Stow for symlink management. The repository contains configuration files for various tools organized in a modular package structure under `packages/`.

**Tech Stack:**
- Shell scripts (Bash)
- Lua (Neovim configuration)
- TOML/YAML configuration files
- Git submodules for external dependencies
- GNU Stow for package management

**Directory Structure:**
- `packages/` - Modular package configurations
  - `common/` - Core configurations shared across all systems
  - `os-linux/` - Linux-specific configurations
  - `os-macos/` - macOS-specific configurations
  - `host-*` - Host-specific configurations
  - `extra-*` - Optional tool configurations (nvim, tmux, wezterm, etc.)
- `scripts/` - Installation and management scripts

## Build, Test, and Validation Commands

### Installation and Setup
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

### Testing/Validation
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

### Linting
```bash
# Lua formatting (for Neovim configs)
stylua --check packages/extra-old-nvim/.config/nvim/

# Lua formatting (fix)
stylua packages/extra-old-nvim/.config/nvim/
```

**No automated tests exist** - validation is primarily manual verification of symlink creation and tool functionality.

## Code Style Guidelines

### Shell Scripts (Bash)

**File Headers:**
```bash
#!/bin/bash
set -euo pipefail  # For library scripts
# OR
set -e  # For main/install scripts (less strict)
```

**Script Structure:**
1. Shebang and set options
2. Source dependencies (logging.sh, constants.sh)
3. Function definitions
4. Main execution logic
5. Call main function at end

**Naming Conventions:**
- Functions: `snake_case` (e.g., `stow_package`, `log_info`, `setup_dotfiles`)
- Variables: `SCREAMING_SNAKE_CASE` for constants/env vars (e.g., `DOTFILES_DIR`, `LOG_LEVEL`)
- Variables: `snake_case` for local variables (e.g., `package`, `setup_script`)
- Files: `kebab-case.sh` (e.g., `stow-all.sh`, `install.sh`)

**Sourcing:**
```bash
. "$(dirname "$0")/logging.sh"  # Relative path with dot notation
. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"  # With fallback
```

**Error Handling:**
- Use `set -e` to exit on errors in main scripts
- Use `set -euo pipefail` for stricter error handling in library scripts
- Check command availability with `command -v <cmd> &>/dev/null`
- Log errors before exit: `log_error "message" && exit 1`

**Logging:**
Always use the logging functions from `logging.sh`:
```bash
log_debug "Debug message"
log_info "Info message"
log_warn "Warning message"
log_error "Error message"
```

**Conditionals:**
```bash
# Prefer [[ ]] over [ ]
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # code
fi

# Check file existence
if [ -f "$file" ]; then
  # code
fi

# Check directory existence
if [ -d "$dir" ]; then
  # code
fi
```

**Environment Variables:**
- Use XDG Base Directory spec: `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, `XDG_BIN_HOME`
- Always provide fallback: `${XDG_CONFIG_HOME:-$HOME/.config}`
- Export variables used by child processes: `export DOTFILES_DIR`

### Lua (Neovim Configuration)

**Formatting (StyLua):**
```lua
-- stylua.toml settings
indent_type = "Spaces"
indent_width = 2
column_width = 120
```

**Style:**
- Use 2 spaces for indentation
- Max line width: 120 characters
- Prefer double quotes for strings (per StyLua default)

### Configuration Files

**TOML:**
```toml
# Use underscores for keys
indent_type = "Spaces"
indent_width = 2
```

**YAML:**
- Use 2 spaces for indentation
- Use lowercase with hyphens for keys

## Git Commit Conventions

Follow conventional commits format defined in `.gitmessage`:

```
<type>(<scope>): <subject>
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration files and scripts
- `chore`: Other changes that don't modify src or test files

**Examples:**
```
feat(nvim): add new keybinding for file search
fix(bash): correct PATH ordering in profile
docs(README): update installation instructions
refactor(stow): simplify package detection logic
```

## Important Patterns and Conventions

### Package Organization
- Each package is self-contained in `packages/<package-name>/`
- Files within packages mirror home directory structure (`.config/`, `.local/bin/`, etc.)
- Setup scripts go in `.local/bin/dotfiles/setup.d/XX-name.sh` (numbered for execution order)
- Bash snippets go in `.config/bashrc.d/XX-name.sh` (sourced in order)

### State Management
- Stowed packages are tracked in `$XDG_DATA_HOME/stow/state`
- One package name per line

### Modular Design
- Common configurations in `common/` package
- OS-specific overrides in `os-linux/` or `os-macos/`
- Host-specific configurations in `host-<hostname>/`
- Optional tools in `extra-<toolname>/`

## Common Tasks

### Adding a New Package
1. Create `packages/<package-name>/` directory
2. Add configuration files mirroring home directory structure
3. Add setup script to `.local/bin/dotfiles/setup.d/` if needed
4. Test with `./scripts/stow.sh <package-name>`

### Modifying Shell Scripts
1. Edit the script
2. Validate syntax: `bash -n <script-path>`
3. Test manually by running the script
4. Commit with appropriate conventional commit message

### Updating Git Submodules
```bash
git submodule update --recursive --remote
git add .gitmodules <submodule-path>
git commit -m "chore(submodules): update to latest versions"
```

## Testing Changes

1. Always test stow operations in dry-run mode first: `stow -n ...`
2. Verify no conflicts with existing files
3. Check symlinks created correctly: `ls -la ~/<path>`
4. For scripts, test on a clean environment if possible
5. Ensure idempotency - scripts should be safe to run multiple times

## Notes for Agents

- This repository has no automated test suite - rely on manual validation
- Always use relative sourcing for script dependencies
- Respect XDG Base Directory specification
- Maintain backward compatibility with existing package structure
- Do not create files outside the `packages/` directory structure
- When adding features, consider which package they belong in
- Test changes with actual stow operations before committing
