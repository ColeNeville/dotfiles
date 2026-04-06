#!/bin/bash
set -euo pipefail

# shellcheck source=../../../../../common/.config/dotfiles/config.sh
. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

# shellcheck source=../../../../../../lib/logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

PACMAN_PACKAGES=("matugen")

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"

# Generate matugen config.toml based on currently stowed packages
STATE_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/stow/state"
MATUGEN_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/matugen"
MATUGEN_CONFIG="${MATUGEN_CONFIG_DIR}/config.toml"
GENERATED_FILES_MANIFEST="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/packages/extra-matugen/generated-files"

log_info "Generating matugen config.toml..."

config='[config]\n'

if grep -qxE "extra-nvim|extra-old-nvim" "$STATE_FILE" 2>/dev/null; then
	config+='\n[templates.nvim-base16-matugen]\n'
	config+='input_path = "~/.config/matugen/templates/nvim-base16-matugen.tera"\n'
	config+='output_path = "~/.config/nvim/colors/base16-matugen.vim"\n'
	log_info "  + nvim-base16-matugen (extra-nvim/extra-old-nvim is stowed)"
fi

mkdir -p "$MATUGEN_CONFIG_DIR"
printf '%b' "$config" >"$MATUGEN_CONFIG"
log_info "Wrote matugen config to $MATUGEN_CONFIG"

# Write generated-files manifest
mkdir -p "$(dirname "$GENERATED_FILES_MANIFEST")"
printf '%s\n' "$MATUGEN_CONFIG" >"$GENERATED_FILES_MANIFEST"
log_info "Wrote generated-files manifest to $GENERATED_FILES_MANIFEST"
