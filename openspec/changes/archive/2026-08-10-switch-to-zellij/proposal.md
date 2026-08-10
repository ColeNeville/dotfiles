## Why

Replace tmux as the terminal multiplexer with zellij, which provides better discoverable keybindings through its mode-based UI, built-in session persistence, stacked panes, and floating windows — all without requiring external plugins.

## What Changes

- **New `extra-zellij` package** containing:
  - `config.kdl` — zellij configuration with session serialization, stacked resize, and force-close behavior tuned for persistence
  - `overrides.d/01-zellij.lua` — wezterm override setting `default_prog` to zellij
  - `bashrc.d/90-zellij.sh` — shell hook to auto-start zellij on new shells (when not in SSH)
  - `zshrc.d/90-zellij.sh` — equivalent zsh hook
  - `.local/bin/dotfiles/setup.d/99-zellij.sh` — install script ensuring zellij is installed via pacman or homebrew
- **Update `extra-wezterm/wezterm.lua`** to generalize override loading: scan `overrides.d/*.lua` in sorted order before loading `local_config.lua`
- **tmux package (`extra-tmux`) kept as-is** — no deprecation, no removal

## Capabilities

### New Capabilities

- `zellij-multiplexer`: zellij as terminal multiplexer with session persistence, stacked panes, and auto-start
- `wezterm-terminal`: modular override system for wezterm configuration, allowing packages to contribute settings

### Modified Capabilities

- *(none — no existing specs to modify)*

## Impact

- `packages/extra-wezterm/.config/wezterm/wezterm.lua` — modified to scan `overrides.d/`
- `packages/extra-tmux/` — untouched, kept for fallback
- `packages/extra-zellij/` — new package
- Host configs (`host-garuda-v7`, macOS) — no changes required
- Shell environments (bash, zsh) — new auto-start hooks via `ZELLIJ` env var check
