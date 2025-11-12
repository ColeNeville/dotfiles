#!/bin/bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

unstow_package() {
  local package=$1
  log_info "Unstowing package: $package"
  # Change to the packages directory
  cd "$STOW_PACKAGES_DIR"
  # Unstow the specified package to the target directory
  stow --target="$STOW_TARGET" --delete "$package"
}

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
  log_error "No package specified to unstow. Usage: $0 <package-name>"
  exit 1
fi

unstow_package "$1"
