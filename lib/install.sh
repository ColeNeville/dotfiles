#!/bin/bash

set -euo pipefail

# shellcheck source=./logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

PACMAN_PACKAGES=${PACMAN_PACKAGES:-()}
PARU_PACKAGES=${PARU_PACKAGES:-()}
HOMEBREW_PACKAGES=${HOMEBREW_PACKAGES:-()}

function install_pacman_packages {
  log_info "Installing packages using pacman..."
  sudo pacman -Sy --noconfirm "${PACMAN_PACKAGES[@]}" &>/dev/null
  log_info "Pacman package installation completed."
}

function install_homebrew_packages {
  log_info "Installing packages using Homebrew..."
  for package in "${HOMEBREW_PACKAGES[@]}"; do
    if ! brew list --formula | grep -q "^${package}\$"; then
      brew install "$package" &>/dev/null
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

function install_paru_packages {
  log_info "Installing packages using paru..."
  paru -Sy --noconfirm "${PARU_PACKAGES}" &>/dev/null
  log_info "Paru packages installation completed."
}

if command -v paru &>/dev/null; then
  install_paru_packages
fi
