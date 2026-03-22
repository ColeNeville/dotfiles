#!/bin/bash
set -euo pipefail

. "$(dirname "$0")/logging.sh"
. "$(dirname "$0")/constants.sh"

unstow_package() {
	local package=$1

	log_info "Unstowing package: $package"

	# Remove any generated files declared by this package's manifest
	local generated_files_manifest="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles/packages/${package}/generated-files"
	if [ -f "$generated_files_manifest" ]; then
		log_info "Removing generated files for $package..."
		while IFS= read -r generated_file; do
			local expanded="${generated_file/#\~/$HOME}"
			if [ -f "$expanded" ]; then
				rm "$expanded"
				log_info "  Removed $expanded"
			fi
		done <"$generated_files_manifest"
		rm "$generated_files_manifest"
	fi

	# Unstow the specified package to the target directory
	stow --target="$STOW_TARGET" --delete "$package" -d "$STOW_PACKAGES_DIR"

	# Update the state file to remove the unstowed package
	if [ -f "$STATE_FILE" ]; then
		grep -vx "$package" "$STATE_FILE" >"${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"
	fi

	# Re-run full setup so other packages can react to the changed stow state
	log_info "Running dotfiles setup..."
	dotfiles.sh setup
}

if ! command -v stow &>/dev/null; then
	echo "Error: stow is not installed or not in PATH"
	echo "Please install stow first:"
	echo "  - On macOS: brew install stow"
	echo "  - On Ubuntu/Debian: sudo apt install stow"
	echo "  - On Fedora/RHEL: sudo dnf install stow"
	echo "  - On Arch Linux: sudo pacman -S stow"
	exit 1
fi

if [ $# -eq 0 ]; then
	log_error "No package specified to unstow. Usage: $0 <package-name>"
	exit 1
fi

unstow_package "$1"
