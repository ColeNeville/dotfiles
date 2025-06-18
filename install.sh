#!/bin/bash

set -e  # Exit on any error

# Configuration
DOTFILES_REPO="https://github.com/ColeNeville/dotfiles.git"  # Replace with your actual repo URL
DOTFILES_DIR="$HOME/.dotfiles"

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

# Check if git is installed
check_git() {
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed. Please install git first."
        exit 1
    fi
}

# Check if stow is installed
check_stow() {
    if ! command -v stow &> /dev/null; then
        log_error "GNU Stow is not installed. Please install stow first."
        log_info "On macOS: brew install stow"
        log_info "On Ubuntu/Debian: sudo apt install stow"
        log_info "On Fedora: sudo dnf install stow"
        exit 1
    fi
}

# Clone or update dotfiles repository
setup_dotfiles() {
    if [ -d "$DOTFILES_DIR" ]; then
        log_warn "Dotfiles directory already exists at $DOTFILES_DIR"
        read -p "Do you want to update it? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "Updating existing dotfiles..."
            cd "$DOTFILES_DIR"
            git pull origin main || git pull origin master
        else
            log_info "Using existing dotfiles directory"
        fi
    else
        log_info "Cloning dotfiles repository to $DOTFILES_DIR..."
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
}

# Run the stow script
run_stow() {
    cd "$DOTFILES_DIR"
    
    if [ -f "stow.sh" ]; then
        log_info "Running stow.sh..."
        chmod +x stow.sh
        ./stow.sh
    else
        log_error "stow.sh not found in $DOTFILES_DIR"
        exit 1
    fi
}

# Main execution
main() {
    log_info "Starting dotfiles installation..."
    
    check_git
    check_stow
    setup_dotfiles
    run_stow
    
    log_info "Dotfiles installation completed successfully!"
    log_info "Your dotfiles are now installed from $DOTFILES_DIR"
}

# Run main function
main "$@"
