#!/bin/bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

stow_package() {
  local package=$1
  if [ -d "$STOW_PACKAGES_DIR/$package" ]; then
    log_info "Stowing package: $package"
    if stow -t "$STOW_TARGET" -S "$package" -d "$STOW_PACKAGES_DIR"; then
      log_info "Successfully stowed $package"
    else
      log_error "Failed to stow $package"
      exit 1
    fi
  else
    log_warn "Package directory does not exist: $package"
  fi
}

# Check if stow is installed
if ! command -v stow &>/dev/null; then
  echo "Error: stow is not installed or not in PATH"
  echo "Please install stow first:"
  echo "  - On macOS: brew install stow"
  echo "  - On Ubuntu/Debian: sudo apt install stow"
  echo "  - On Fedora/RHEL: sudo dnf install stow"
  echo "  - On Arch Linux: sudo pacman -S stow"
  exit 1
fi

if [ $# -eq 0 ]; then
  log_error "No package specified to stow. Usage: $0 <package-name>"
  exit 1
fi

stow_package "$1"
