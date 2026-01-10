#!/bin/bash
set -euo pipefail

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Configuration
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export STOW_TARGET="${STOW_TARGET:-$HOME}"
export STOW_PACKAGES_DIR="${DOTFILES_DIR}/packages"

export STATE_FILE="${XDG_DATA_HOME}/stow/state"
