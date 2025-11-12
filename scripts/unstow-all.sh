#!/usr/bin/env bash

set -eou pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

# Unstow all packages
unstow_packages() {
  log_info "Unstowing dotfiles packages to target: $STOW_TARGET"

  # Find all directories that could be stow packages (exclude hidden dirs and common non-package dirs)
  for package in "${STOW_PACKAGES_DIR}"/*; do
    # Pull just the directory name
    package=$(basename "$package")

    # Skip common non-package directories
    if [[ "$package" == ".git" || "$package" == "scripts" || "$package" == "docs" ]]; then
      continue
    fi

    "${DOTFILES_DIR}/scripts/unstow.sh" "$package"
  done
}

unstow_packages
