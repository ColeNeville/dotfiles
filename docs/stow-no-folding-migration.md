# Migrating to `--no-folding` Stow Configuration

## Context

GNU Stow's default behaviour is to "fold" a directory into a single symlink when all
of its contents can be linked without conflict. For example, if a package contains
`.config/matugen/` and nothing else owns `~/.config/matugen/`, stow creates:

```
~/.config/matugen -> ../.dotfiles/packages/extra-matugen/.config/matugen
```

This is a problem when a setup script needs to write a generated file into that
directory at runtime — the write goes through the symlink and lands inside the repo.
This was the case with `extra-matugen`, whose setup script generates `config.toml`
into `~/.config/matugen/` at setup time.

The fix is to add `--no-folding` to `~/.stowrc`. With this flag, stow always creates
real directories and only symlinks individual files and subdirectories inside them.
Fresh installs handle this automatically via `install.sh`. This document covers the
manual migration steps for existing systems.

## What Changes on Disk

| Path | Before | After |
|---|---|---|
| `~/.config/git` | symlink → `common/.config/git` | real dir, contents symlinked individually |
| `~/.config/lazygit` | symlink → `extra-lazygit/.config/lazygit` | real dir, contents symlinked individually |
| `~/.config/matugen` | symlink → `extra-matugen/.config/matugen` | real dir, `templates/` symlinked inside, `config.toml` a plain generated file |
| `~/.config/niri` | symlink → `host-garuda-v7/.config/niri` | real dir, contents symlinked individually |
| `~/.config/opencode` | symlink → `extra-opencode/.config/opencode` | real dir, contents symlinked individually |
| `~/.local/share/dotfiles` | symlink → `common/.local/share/dotfiles` | real dir, contents symlinked individually |

## Migration Steps

### 1. Ensure `--no-folding` is in `~/.stowrc`

Check whether the flag is already present:

```bash
grep -qx '\-\-no-folding' ~/.stowrc 2>/dev/null && echo "already set" || echo "needs adding"
```

If it needs adding:

```bash
echo '--no-folding' >> ~/.stowrc
```

### 2. Remove existing directory symlinks

Stow will not replace existing directory symlinks with real directories automatically.
They must be removed first so stow can re-create them correctly under `--no-folding`.

```bash
rm ~/.config/git ~/.config/lazygit ~/.config/matugen \
   ~/.config/niri ~/.config/opencode ~/.local/share/dotfiles
```

Adjust this list to match the directory symlinks present on your system (see the
table in [What Changes on Disk](#what-changes-on-disk) above).

### 3. Re-stow all packages

Run `stow-all.sh` to create real directories populated with individual symlinks in
place of the removed directory symlinks.

```bash
~/.dotfiles/scripts/stow-all.sh
```

When prompted for extra packages, re-select any that were previously installed.

### 4. Regenerate setup outputs

Re-run setup so that generated files (such as `~/.config/matugen/config.toml`) are
written into the now-real directories rather than through a repo symlink.

```bash
dotfiles.sh setup
```

## Verification

Confirm all previously-folded paths are now real directories (output should start
with `d`, not `l`):

```bash
ls -ld ~/.config/git ~/.config/lazygit ~/.config/matugen \
        ~/.config/niri ~/.config/opencode ~/.local/share/dotfiles
```

Confirm `config.toml` is a plain generated file and not a symlink:

```bash
ls -la ~/.config/matugen/config.toml
```

Confirm matugen can read its config and process templates without errors:

```bash
matugen color hex "#6750a4" -t scheme-tonal-spot -m dark --dry-run
```

All three checks passing means the migration is complete.
