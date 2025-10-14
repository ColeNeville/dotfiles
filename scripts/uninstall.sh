#!/bin/bash

set -e # Exit on any error

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

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

# Check if dotfiles directory exists
check_dotfiles_dir() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    log_error "Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
  fi
}

# Run the unstow script
run_unstow() {
  cd "$DOTFILES_DIR"

  if [ -f "scripts/unstow.sh" ]; then
    log_info "Running unstow.sh..."
    ./scripts/unstow.sh
  else
    log_error "unstow.sh not found in $DOTFILES_DIR"
    exit 1
  fi
}

# Remove dotfiles directory
remove_dotfiles_dir() {
  read -p "Do you want to remove the dotfiles directory ($DOTFILES_DIR)? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "Removing dotfiles directory..."
    rm -rf "$DOTFILES_DIR"
    log_info "Dotfiles directory removed"
  else
    log_info "Keeping dotfiles directory at $DOTFILES_DIR"
  fi
}

# Show what will be done
show_preview() {
  echo
  log_warn "This will:"
  echo "  1. Unstow all dotfiles packages from $DOTFILES_DIR"
  echo "  2. Remove symlinks created by stow"
  echo "  3. Optionally remove the dotfiles directory"
  echo
  read -p "Do you want to continue? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "Uninstallation cancelled"
    exit 0
  fi
}

# Main execution
main() {
  log_info "Starting dotfiles uninstallation..."

  check_dotfiles_dir
  show_preview
  run_unstow
  remove_dotfiles_dir

  log_info "Dotfiles uninstallation completed!"
}

# Run main function
main "$@"
