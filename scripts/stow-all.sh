#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

# Stow packages
stow_packages() {
  cd "$DOTFILES_DIR/packages"

  log_info "Stowing dotfiles packages to target: $STOW_TARGET"

  # List of packages to stow
  packages=(common)

  # Determine OS type
  case "$OSTYPE" in
  linux-gnu*)
    packages+=(linux)
    ;;
  darwin*)
    packages+=(macos)
    ;;
  *)
    log_warn "Unsupported OS type: $OSTYPE. Only 'linux' and 'macos' packages will be stowed."
    ;;
  esac

  # Determine hostname-specific package
  case "$HOSTNAME" in
  garuda-v6)
    packages+=(garuda-v6)
    ;;
  *)
    log_info "No hostname-specific package found for: $HOSTNAME"
    ;;
  esac

  for package in "${packages[@]}"; do
    "${DOTFILES_DIR}/scripts/stow.sh" "$package"
  done
}

# Main execution
stow_packages
