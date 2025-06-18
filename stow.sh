#!/usr/bin/env bash

set -e

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
STOW_TARGET="${STOW_TARGET:-$HOME}"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo "Error: stow is not installed or not in PATH"
  echo "Please install stow first:"
  echo "  - On macOS: brew install stow"
  echo "  - On Ubuntu/Debian: sudo apt install stow"
  echo "  - On Fedora/RHEL: sudo dnf install stow"
  exit 1
fi

# Change to packages directory for stow operations
cd "$DOTFILES_DIR/packages"

stow -t "$STOW_TARGET" -S \
  aider \
  bash \
  emacs \
  git \
  gnupg \
  tmux \
  wezterm

# Install macOS-specific configuration if running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  stow -t "$STOW_TARGET" -S macos
fi
