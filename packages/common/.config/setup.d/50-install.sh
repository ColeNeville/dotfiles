set -euo pipefail

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/setup"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/setup"

NVM_VERSION="0.40.3"
DEFAULT_NODE_VERSION="24"

CODEX_VERSION="0.72.0"
CLAUDE_VERSION="2.0.71"
OPENCODE_VERSION="1.0.164"

. "${DATA_DIR}/logging.sh"

PACMAN_PACKAGES=(
  "bash"
  "direnv"
  "git"
  "curl"
  "htop"
  "neovim"
  "tmux"
  "wget"
)
HOMEBREW_PACKAGES=(
  "bash"
  "direnv"
  "git"
  "curl"
  "htop"
  "neovim"
  "tmux"
  "wget"
)

NPM_PACKAGES=(
  "@openai/codex@$CODEX_VERSION"
  "@anthropic-ai/claude-code@$CLAUDE_VERSION"
  "opencode-ai@$OPENCODE_VERSION"
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

install_nvm() {
  local nvm_dir

  # Determine NVM installation directory use NVM_DIR if set, otherwise default to ~/.nvm
  if [ -n "$NVM_DIR" ]; then
    nvm_dir="$NVM_DIR"
    log_info "Using NVM_DIR from environment: $nvm_dir"
  else
    nvm_dir="$HOME/.nvm"
    log_info "NVM_DIR not set, defaulting to: $nvm_dir"
  fi

  # Clone NVM repository if not already present
  if [ ! -d "$nvm_dir" ]; then
    log_info "NVM not found, proceeding with installation..."
    git clone "https://github.com/nvm-sh/nvm.git" "$nvm_dir"
  fi

  cd "$nvm_dir"
  log_info "Checking out NVM version $NVM_VERSION..."
  git checkout "v$NVM_VERSION"

  # Set default version of Node.js
  log_info "Setting up NVM and installing Node.js version $DEFAULT_NODE_VERSION..."
  . "$nvm_dir/nvm.sh"
  nvm install $DEFAULT_NODE_VERSION
  nvm alias default $DEFAULT_NODE_VERSION
}

install_npm_packages() {
  log_info "Installing global NPM packages..."
  for package in "${NPM_PACKAGES[@]}"; do
    if ! npm list -g --depth=0 | grep -q "$package"; then
      npm install -g "$package"
      log_info "Installed $package via NPM."
    else
      log_info "$package is already installed via NPM."
    fi
  done
  log_info "NPM package installation completed."
}

# Install packages based on available package manager
if command -v pacman >/dev/null 2>&1; then
  install_pacman_packages
elif command -v brew >/dev/null 2>&1; then
  install_homebrew_packages
else
  log_warn "No supported package manager found"
fi

install_nvm
install_npm_packages
