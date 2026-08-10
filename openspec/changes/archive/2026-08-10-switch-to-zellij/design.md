## Context

The dotfiles repository uses GNU Stow for symlink management across Linux and macOS hosts. Terminal multiplexing is currently handled by tmux 3.7b, configured via `packages/extra-tmux/.config/tmux/tmux.conf` with TPM-managed plugins (tmux-sensible, tmux-menus, tmux-gruvbox). The user's workflow lives inside a fullscreen wezterm terminal running under the niri Wayland compositor.

Zellij 0.44.3 is already installed on the system and has been used experimentally. The user's existing zellij config at `~/.config/zellij/config.kdl` is fully customized with keybinds, themes, and plugins.

## Goals / Non-Goals

**Goals:**

- Replace tmux as the default multiplexer with zellij
- Provide discoverable keybindings via zellij's built-in mode system (no external plugin needed)
- Enable session persistence so sessions survive terminal crashes and disconnects
- Support stacked panes and floating windows
- Allow wezterm to auto-start zellij via a shell hook
- Enable modular wezterm configuration so packages can contribute settings
- Keep tmux installed and configured as a fallback (no removal)

**Non-Goals:**

- Migrating tmux configuration to zellij (config languages are incompatible — tmux.conf vs KDL)
- Replacing niri window management (niri handles non-terminal windows)
- Deprecating or removing the `extra-tmux` package
- Adding custom zellij layouts or plugins beyond what's in the default distribution
- Supporting nested zellij sessions (wezterm → zellij → SSH → tmux is acceptable)

## Decisions

### D1: Shell-based auto-start instead of wezterm `default_prog`

**Decision:** Use a shell hook (`bashrc.d`/`zshrc.d`) that checks `$ZELLIJ` and `$SSH_CONNECTION` to auto-start zellij.

**Rationale:**

- `wezterm default_prog` would spawn a new zellij session in every tab, including nested ones
- The shell hook checks `ZELLIJ` env var — if already inside zellij, it skips the exec
- SSH sessions bypass zellij entirely (no multiplexing needed over SSH)
- This pattern (option C from exploration) handles all three cases cleanly

**Alternatives considered:**

- `default_prog = { "zellij" }` in wezterm config — simple but nests zellij in new tabs
- `default_prog = { "zellij", "attach" }` — attaches to existing session but fails if none exists

### D2: Modular wezterm override system using `overrides.d/` directory

**Decision:** Generalize wezterm.lua to scan `overrides.d/*.lua` in sorted filename order, then load `local_config.lua` last.

**Rationale:**

- Each package (extra-zellij, etc.) contributes one override file: `overrides.d/01-zellij.lua`
- Sorted filenames ensure deterministic priority: `01-` < `02-` < `99-`
- `local_config.lua` retains highest priority for host/personal overrides
- Missing `overrides.d/` directory is handled gracefully (no empty dir needed)
- This is backward compatible — existing `local_config.lua` continues to work

**Alternatives considered:**

- Single `local_config.lua` per host — works but doesn't support package contributions
- A manifest file listing override files — adds complexity, file sorting is simpler

### D3: zellij config with persistence enabled, mouse disabled

**Decision:** Enable `session_serialization true`, `stacked_resize true`, `on_force_close "detach"`, keep `mouse_mode false`.

**Rationale:**

- Session serialization provides the persistence tmux users expect (survives detach/crash)
- `on_force_close "detach"` instead of `"quit"` — closing the terminal window detaches rather than killing the session
- Stacked resize enables the stacked pane feature the user uses manually
- Mouse mode stays disabled — the user prefers keyboard-driven workflow
- Theme stays as dracula (user said "leave for now")

**Alternatives considered:**

- `on_force_close "quit"` — current setting, but loses sessions on terminal crash
- `mouse_mode true` — useful for resizing but conflicts with text selection in some apps

### D4: Package structure — `extra-zellij` as standalone package

**Decision:** All zellij-related files live under `packages/extra-zellij/` mirroring the existing `extra-tmux` pattern.

**Rationale:**

- Consistent with the existing package model (OS-specific, host-specific, tool-specific)
- Easy to enable/disable via stow
- Shell hooks in `bashrc.d/` and `zshrc.d/` follow the numbered convention
- Wezterm override in `overrides.d/` follows the new convention
- Setup script in `.local/bin/dotfiles/setup.d/` follows the same convention as other packages

```
packages/extra-zellij/
├── .config/
│   ├── zellij/config.kdl
│   ├── wezterm/overrides.d/01-zellij.lua
│   ├── bashrc.d/90-zellij.sh
│   └── zshrc.d/90-zellij.sh
└── .local/
    └── bin/
        └── dotfiles/
            └── setup.d/
                └── 99-zellij.sh
```

### D5: Install process via setup.d script

**Decision:** Use the existing `setup.d/` pattern to ensure zellij is installed via pacman (Linux) or homebrew (macOS).

**Rationale:**

- Follows the same pattern as `extra-nvim` and `extra-lazygit` packages
- Declarative `PACMAN_PACKAGES`/`HOMEBREW_PACKAGES` arrays — simple and maintainable
- `lib/install.sh` handles package manager detection automatically
- No custom install logic needed — zellij is a single package dependency
- No config migration — stow replaces the existing config file with a symlink

**Alternatives considered:**

- Manual install instructions in README — less reliable, easy to forget
- Inline install script — duplicates logic already in `lib/install.sh`

## Risks / Trade-offs

| Risk | Mitigation |
| ------ | ----------- |
| zellij keybinds require `Ctrl-g` prefix — more keystrokes than tmux's prefix-free bindings | User explicitly prefers zellij's discoverable mode system; modes are self-documenting |
| No right-click context menus (tmux-menus has no zellij equivalent) | Keyboard shortcuts replace menu actions; user hasn't expressed attachment to menus |
| Session serialization adds disk I/O | Configured with `serialization_interval` default; minimal overhead |
| Shell hook might not trigger in all contexts (e.g., `wezterm cli` commands) | `wezterm default_prog` can be set as a secondary fallback if needed |
| Nested sessions (zellij inside zellij) if hook fails | Shell checks `$ZELLIJ` env var — prevents nesting |
| tmux plugins (sensible, gruvbox, menus) don't translate | zellij has equivalent built-in features; no plugin migration needed |

## Migration Plan

1. Create `extra-zellij` package with all files including setup.d script
2. Update `extra-wezterm/wezterm.lua` to support `overrides.d/`
3. Stow both packages alongside existing `extra-tmux`
4. Run setup.d to ensure zellij is installed
5. Test: open wezterm → should auto-start zellij
6. Test: open new wezterm tab → should join existing zellij session
7. Test: SSH into host → should NOT enter zellij
8. User adopts zellij, keeps tmux as fallback
9. (Future) Migrate `local_config.lua` into `overrides.d/` system

## Open Questions

- Should `serialization_interval` be tuned from the default? (default is 10000ms which seems very high — possibly a bug in the commented config)
- Should `pane_frames` be explicitly set to `true` for visual clarity?
- Should `copy_clipboard` be `primary` (current) or `system`? (currently `primary` in existing config)
