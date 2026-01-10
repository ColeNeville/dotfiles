#!/usr/bin/env bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

# List all the extra packages available and ask the user which ones to install
prompt_for_extras() {
  local packages=()
  local index=1

  # Read STOW_STATE_FILE to get already stowed packages
  # This prevents suggesting packages that are already installed
  local stowed_packages=()
  if [ -f "$STATE_FILE" ]; then
    mapfile -t stowed_packages <"$STATE_FILE"
  fi

  log_info "Available extra packages:"
  for package_dir in "${STOW_PACKAGES_DIR}/extra-"*; do
    if [ -d "$package_dir" ]; then
      local package_name

      if [[ " ${stowed_packages[*]} " == *" $(basename "$package_dir") "* ]]; then
        continue
      fi

      package_name=$(basename "$package_dir")
      packages+=("$package_name")
      echo "  [$index] $package_name"
      ((index++))
    fi
  done

  read -p "Enter the numbers of the extra packages to install (comma-separated), or press Enter to skip: " input
  IFS=',' read -ra selected_indices <<<"$input"
  
  for idx in "${selected_indices[@]}"; do
    if [[ "$idx" =~ ^[0-9]+$ ]] && [ "$idx" -ge 1 ] && [ "$idx" -le "${#packages[@]}" ]; then
      local selected_package="${packages[$((idx - 1))]}"
      log_info "Stowing extra package: $selected_package"
      "${DOTFILES_DIR}/scripts/stow.sh" "${selected_package}"
    else
      log_warn "Invalid selection: $idx. Skipping."
    fi
  done

  for stowed in "${stowed_packages[@]}"; do
    # Stow the package again to ensure it has any new changes applied
    log_info "Re-stowing previously installed package: $stowed"
    "${DOTFILES_DIR}/scripts/stow.sh" "${stowed}"
  done
}

# Stow packages
stow_packages() {
  local stow_script="${DOTFILES_DIR}/scripts/stow.sh"

  log_info "Stowing dotfiles packages to target: $STOW_TARGET"

  "${stow_script}" common

  # Determine OS type
  case "$OSTYPE" in
  linux-gnu*)
    "${stow_script}" os-linux
    ;;
  darwin*)
    "${stow_script}" os-macos
    ;;
  *)
    log_warn "Unsupported OS type: $OSTYPE. Only 'linux' and 'macos' packages will be stowed."
    ;;
  esac

  # Stow package for hostname if it exists
  if [ -d "${DOTFILES_DIR}/packages/host-${HOSTNAME}" ]; then
    "${stow_script}" "host-${HOSTNAME}"
  else
    log_info "No hostname-specific package found for ${HOSTNAME}. Skipping."
  fi

  prompt_for_extras
}

# Main execution
stow_packages
