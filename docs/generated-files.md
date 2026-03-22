# Generated Files

This document describes the generated-files system, which tracks files that are
produced by setup scripts rather than managed directly by GNU Stow.

## Overview

Some packages need to write configuration files at setup time — for example, because
the content depends on which other packages are currently stowed. These files cannot
be checked into the package directory and stowed as symlinks; they must be generated
dynamically.

The generated-files system provides a lightweight manifest mechanism so that
`unstow.sh` can clean up generated files when a package is removed.

## Manifest Location

Each package that generates files writes a manifest at:

```
~/.local/share/dotfiles/packages/<package_name>/generated-files
```

The manifest is a plain text file with one absolute path per line. Tilde (`~`) is
supported as shorthand for `$HOME`.

Example (`~/.local/share/dotfiles/packages/extra-matugen/generated-files`):

```
~/.config/matugen/config.toml
```

## Writing the Manifest

The manifest is written by the package's setup script (in `setup.d/`) immediately
after it writes the generated files. The setup script is responsible for:

1. Writing the generated file(s) to their destination paths
2. Writing the manifest with one path per line

Example pattern in a `setup.d/` script:

```bash
GENERATED_FILES_MANIFEST="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/packages/my-package/generated-files"

# ... write generated files ...

mkdir -p "$(dirname "$GENERATED_FILES_MANIFEST")"
printf '%s\n' \
  "~/.config/some-tool/config.toml" \
  >"$GENERATED_FILES_MANIFEST"
```

Because the manifest itself lives under `~/.local/share/dotfiles/` (not under
`~/.config/` or any stowed path), it does not need to be listed in itself.

## Cleanup on Unstow

When `scripts/unstow.sh` removes a package it checks for a manifest at the path
above. If one exists, it:

1. Reads each line of the manifest
2. Expands `~` to `$HOME`
3. Deletes the file if it exists
4. Deletes the manifest itself
5. Proceeds with the normal unstow and state-file removal
6. Re-runs `dotfiles.sh setup` so remaining packages can react to the changed state

## When to Use This System

Use the generated-files manifest whenever a setup script writes a file that:

- Is not checked into the repo (because its content is dynamic)
- Is not managed by stow (because it lives outside any package directory)
- Should be cleaned up when the package is unstowed

Do **not** use it for files that are already stow-managed (checked into a package
directory and symlinked by stow) — those are removed automatically when the package
is unstowed.

## Current Users

| Package | Generated File | Condition |
|---|---|---|
| `extra-matugen` | `~/.config/matugen/config.toml` | Always (content varies by stowed packages) |

The `config.toml` content is conditional: the `[templates.nvim-base16-matugen]`
block is only included when `extra-nvim` or `extra-old-nvim` is in the stow state
file. This ensures matugen only runs templates for tools that are actually installed.
