#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

# Stow packages
stow_packages() {
  local stow_script="${DOTFILES_DIR}/scripts/stow.sh"

  cd "$DOTFILES_DIR/packages"

  log_info "Stowing dotfiles packages to target: $STOW_TARGET"

  "${stow_script}" common

  # Determine OS type
  case "$OSTYPE" in
  linux-gnu*)
    "${stow_script}" linux
    ;;
  darwin*)
    "${stow_script}" macos
    ;;
  *)
    log_warn "Unsupported OS type: $OSTYPE. Only 'linux' and 'macos' packages will be stowed."
    ;;
  esac

  # Stow package for hostname if it exists
  if [ -f "${DOTFILES_DIR}/packages/$(hostname)" ]; then
    "${stow_script}" "$(hostname)"
  else
    log_info "No hostname-specific package found for $(hostname). Skipping."
  fi

  for package in "${packages[@]}"; do
    "${DOTFILES_DIR}/scripts/stow.sh" "$package"
  done
}

# Main execution
stow_packages
