#!/bin/bash

set -euo pipefail

. "${DATA_DIR}/logging.sh"

HOMEBREW_PACKAGES=${HOMEBREW_PACKAGES:-()}
PACMAN_PACKAGES=${PACMAN_PACKAGES:-()}

install_pacman_packages() {
  log_info "Installing packages using pacman..."
  sudo pacman -Sy --noconfirm "${PACMAN_PACKAGES[@]}"
  log_info "Pacman package installation completed."
}

install_homebrew_packages() {
  log_info "Installing packages using Homebrew..."
  for package in "${HOMEBREW_PACKAGES[@]}"; do
    if ! brew list --formula | grep -q "^${package}\$"; then
      brew install "$package"
      log_info "Installed $package via Homebrew."
    else
      log_info "$package is already installed via Homebrew."
    fi
  done
  log_info "Homebrew package installation completed."
}

if command -v pacman &>/dev/null; then
  install_pacman_packages
elif command -v brew &>/dev/null; then
  install_homebrew_packages
else
  log_error "No supported package manager found (pacman or Homebrew)."
fi
