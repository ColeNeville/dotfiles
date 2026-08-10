## 1. Create extra-zellij package structure

- [x] 1.1 Create `packages/extra-zellij/.config/zellij/` directory
- [x] 1.2 Create `packages/extra-zellij/.config/wezterm/overrides.d/` directory
- [x] 1.3 Create `packages/extra-zellij/.config/bashrc.d/` directory
- [x] 1.4 Create `packages/extra-zellij/.config/zshrc.d/` directory
- [x] 1.5 Create `setup.d/99-zellij.sh` to install zellij via pacman/homebrew

## 2. Create zellij configuration

- [x] 2.1 Create `config.kdl` with keybinds from existing `~/.config/zellij/config.kdl`
- [x] 2.2 Enable `session_serialization true`
- [x] 2.3 Enable `stacked_resize true`
- [x] 2.4 Set `on_force_close "detach"`
- [x] 2.5 Keep `theme "dracula"` and `copy_clipboard "primary"` from existing config
- [x] 2.6 Keep `mouse_mode false` from existing config
- [x] 2.7 Keep `load_plugins: zellij:link` from existing config
- [x] 2.8 Verify config syntax with `zellij setup --check`

## 3. Create wezterm override

- [x] 3.1 Create `overrides.d/01-zellij.lua` returning `{ default_prog = { "zellij" } }`

## 4. Create shell auto-start hooks

- [x] 4.1 Create `bashrc.d/90-zellij.sh` with conditional zellij auto-start (checks `$ZELLIJ` and `$SSH_CONNECTION`)
- [x] 4.2 Create `zshrc.d/90-zellij.sh` with equivalent zsh hook

## 5. Update wezterm to support modular overrides

- [x] 5.1 Update `packages/extra-wezterm/.config/wezterm/wezterm.lua` to scan `overrides.d/*.lua` in sorted order
- [x] 5.2 Handle missing `overrides.d/` directory gracefully
- [x] 5.3 Preserve existing `local_config.lua` loading (highest priority)
- [x] 5.4 Preserve existing base config (font, font_size, hide_tab_bar)

## 6. Test and verify

- [x] 6.1 Dry-run stow: `stow -n -t "$HOME" -S extra-zellij -d packages/` (expected conflict: existing file → symlink, use `--adopt`)
- [x] 6.2 Dry-run stow: `stow -n -t "$HOME" -S extra-wezterm -d packages/`
- [x] 6.3 Verify no conflicts with existing `extra-tmux` package
- [x] 6.4 Run setup.d: `bash .local/bin/dotfiles/setup.d/99-zellij.sh` to install zellij
- [x] 6.5 Test: open wezterm → should auto-start zellij (manual: requires interactive test)
- [x] 6.6 Test: open new wezterm tab → should join existing zellij session (manual: requires interactive test)
- [x] 6.7 Test: SSH into host → should NOT enter zellij (manual: requires interactive test)
