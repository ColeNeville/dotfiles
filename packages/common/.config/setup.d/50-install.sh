DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/setup"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/setup"

. "${DATA_DIR}/logging.sh"

PACMAN_PACKAGES=(
  "bash"
  "git"
  "curl"
  "htop"
  "neovim"
  "tmux"
  "wget"
)
HOMEBREW_PACKAGES=(
  "bash"
  "git"
  "curl"
  "htop"
  "neovim"
  "tmux"
  "wget"
)

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

# Install packages based on available package manager
if command -v pacman >/dev/null 2>&1; then
  install_pacman_packages
elif command -v brew >/dev/null 2>&1; then
  install_homebrew_packages
else
  log_warn "No supported package manager found"
fi

# Install Node Version Manager (NVM)
# Check if nvm is installed
if [ -d "$NVM_DIR" ]; then
  log_info "NVM is already installed."
else
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh > "${STATE_DIR}/nvm-install.sh"
  # Prompt to review the NVM install script
  echo "Please review the NVM install script at ${STATE_DIR}/nvm-install.sh before proceeding."
  nvim "${STATE_DIR}/nvm-install.sh"
  read -r -p "Do you want to execute the NVM install script? (y/n): " choice

  while [[ "$choice" != "y" && "$choice" != "Y" && "$choice" != "n" && "$choice" != "N" ]]; do
    read -r -p "Invalid input. Please enter 'y' to proceed or 'n' to skip: " choice
  done

  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    bash "${STATE_DIR}/nvm-install.sh"
    log_info "NVM installation completed."
  else
    log_info "NVM installation skipped by user."
  fi
fi
