
## Build, Lint, and Test

- **Linting (Lua)**: Use `stylua` to format Lua code. Config in `packages/neovim/.config/nvim/stylua.toml`.
- **Linting (Shell)**: Use `shellcheck` for shell scripts.
- **Testing**: No testing framework is currently in use.

## Code Style Guidelines

- **Formatting**:
  - **Lua**: 2-space indentation, 120-char line width.
  - **Shell**: Follow standard shell script best practices.
- **Naming Conventions**:
  - **Shell**: Use `snake_case` for variables and functions.
- **Error Handling**:
  - **Shell**: Use `set -e` to exit on any error in scripts.
- **Git Commits**:
  - Follow the Conventional Commits specification as defined in `.gitmessage`.
  - Example: `feat(neovim): add new plugin for file browsing`
- **Imports**:
  - Not applicable in this dotfiles repository.

## General

- This is a dotfiles repository. Changes should be modular and well-documented.
- Use the `stow` command to manage packages.
