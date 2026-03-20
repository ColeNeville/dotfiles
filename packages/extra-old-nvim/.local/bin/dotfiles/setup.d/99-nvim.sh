#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

# shellcheck source=../../../../../../lib/logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

PACMAN_PACKAGES=(
  # Neovim itself
  "neovim"

  # Language servers and tools
  "git"
  "make"
  "unzip"
  "gcc" # GNU Compiler Collection
  "rg" # ripgrep
  "fd" # fd-find
)

HOMEBREW_PACKAGES=(
  # Neovim itself
  "neovim"
 
  # Language servers and tools
  "git"
  "make"
  "unzip"
  "gcc" # GNU Compiler Collection
  "ripgrep"
  "fd"
)

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"
