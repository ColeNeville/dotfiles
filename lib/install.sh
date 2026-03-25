#!/bin/bash

set -euo pipefail

# shellcheck source=./logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

if [ -z "${PACMAN_PACKAGES+x}" ]; then PACMAN_PACKAGES=(); fi
if [ -z "${PARU_PACKAGES+x}" ]; then PARU_PACKAGES=(); fi
if [ -z "${HOMEBREW_PACKAGES+x}" ]; then HOMEBREW_PACKAGES=(); fi

function install_pacman_packages {
	if [[ ${#PACMAN_PACKAGES[@]} -eq 0 ]]; then
		return 0
	fi
	log_info "Installing packages using pacman..."
	for package in "${PACMAN_PACKAGES[@]}"; do
		if ! pacman -Q "$package" &>/dev/null; then
			sudo pacman -Sy --noconfirm "$package" 1>/dev/null
			log_info "Installed $package via pacman."
		else
			log_info "$package is already installed via pacman."
		fi
	done
	log_info "Pacman package installation completed."
}

function install_homebrew_packages {
	if [[ ${#HOMEBREW_PACKAGES[@]} -eq 0 ]]; then
		return 0
	fi
	log_info "Installing packages using Homebrew..."
	for package in "${HOMEBREW_PACKAGES[@]}"; do
		if ! brew list --formula | grep -q "^${package}\$"; then
			brew install "$package" 1>/dev/null
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
	if [[ ${#PARU_PACKAGES[@]} -eq 0 ]]; then
		return 0
	fi
	log_info "Installing packages using paru..."
	for package in "${PARU_PACKAGES[@]}"; do
		if ! paru -Q "$package" &>/dev/null; then
			paru -Sy --noconfirm "$package" 1>/dev/null
			log_info "Installed $package via paru."
		else
			log_info "$package is already installed via paru."
		fi
	done
	log_info "Paru packages installation completed."
}

if command -v paru &>/dev/null; then
	install_paru_packages
elif command -v pacman &>/dev/null && [[ ${#PARU_PACKAGES[@]} -gt 0 ]]; then
	log_error "paru is not installed but PARU_PACKAGES is not empty: ${PARU_PACKAGES[*]}"
fi
