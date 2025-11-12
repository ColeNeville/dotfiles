#!/bin/bash
set -euo pipefail

# Configuration
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export STOW_TARGET="${STOW_TARGET:-$HOME}"
export STOW_PACKAGES_DIR="${DOTFILES_DIR}/packages"
