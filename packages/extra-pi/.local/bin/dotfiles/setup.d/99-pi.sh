#!/bin/bash
set -euo pipefail

# shellcheck source=../../../../../common/.config/dotfiles/config.sh
. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

BUN_PACKAGES=("@earendil-works/pi-coding-agent")

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"
