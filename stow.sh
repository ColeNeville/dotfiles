#!/usr/bin/env bash

set -e

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
STOW_TARGET="${STOW_TARGET:-$HOME}"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
  echo "Error: stow is not installed or not in PATH"
  echo "Please install stow first:"
  echo "  - On macOS: brew install stow"
  echo "  - On Ubuntu/Debian: sudo apt install stow"
  echo "  - On Fedora/RHEL: sudo dnf install stow"
  exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Stow packages
stow_packages() {
    cd "$DOTFILES_DIR/packages"
    
    log_info "Stowing dotfiles packages to target: $STOW_TARGET"
    
    # List of packages to stow
    packages=(aider bash emacs git gnupg tmux wezterm neovim)

    # Add linux-specific packages if runnning linux
    if [[ "$OSTYPE" == "linux"* ]]; then
      packages+=(toolbx)
    fi

    # Add macOS-specific package if running on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        packages+=(macos)
    fi
    
    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            log_info "Stowing package: $package"
            if stow -t "$STOW_TARGET" -S "$package"; then
                log_info "Successfully stowed $package"
            else
                log_error "Failed to stow $package"
                exit 1
            fi
        else
            log_warn "Package directory not found: $package"
        fi
    done
}

# Main execution
stow_packages
