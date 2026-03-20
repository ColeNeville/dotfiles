#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

# Create necessary directories
mkdir -p "${SETUP_DATA_DIR}"

