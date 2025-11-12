#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

# Stow packages
stow_packages() {
  cd "$DOTFILES_DIR/packages"

  log_info "Stowing dotfiles packages to target: $STOW_TARGET"

  # List of packages to stow
  packages=(bash git gnupg lazygit neovim tmux wezterm)

  # Add macOS-specific package if running on macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    packages+=(macos)
  fi

  for package in "${packages[@]}"; do
    "${DOTFILES_DIR}/scripts/stow.sh" "$package"
  done
}

# Main execution
stow_packages
