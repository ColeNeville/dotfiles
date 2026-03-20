#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

PACKMAN_PACKAGES=("vifm")

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"
