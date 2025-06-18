#!/bin/bash

set -e  # Exit on any error

# Configuration
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

# Check if stow is installed
check_stow() {
    if ! command -v stow &> /dev/null; then
        log_error "GNU Stow is not installed. Cannot unstow dotfiles."
        exit 1
    fi
}

# Check if dotfiles directory exists
check_dotfiles_dir() {
    if [ ! -d "$DOTFILES_DIR" ]; then
        log_error "Dotfiles directory not found at $DOTFILES_DIR"
        exit 1
    fi
}

# Unstow all packages
unstow_packages() {
    cd "$DOTFILES_DIR"
    
    log_info "Unstowing dotfiles packages..."
    
    # Find all directories that could be stow packages (exclude hidden dirs and common non-package dirs)
    for package in */; do
        package=${package%/}  # Remove trailing slash
        
        # Skip common non-package directories
        if [[ "$package" == ".git" || "$package" == "scripts" || "$package" == "docs" ]]; then
            continue
        fi
        
        log_info "Unstowing package: $package"
        if stow -D "$package" 2>/dev/null; then
            log_info "Successfully unstowed $package"
        else
            log_warn "Failed to unstow $package (may not have been stowed)"
        fi
    done
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
    
    check_stow
    check_dotfiles_dir
    show_preview
    unstow_packages
    remove_dotfiles_dir
    
    log_info "Dotfiles uninstallation completed!"
}

# Run main function
main "$@"
