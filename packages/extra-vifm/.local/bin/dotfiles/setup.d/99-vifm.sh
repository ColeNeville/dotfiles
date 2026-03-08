#!/bin/bash

set -euo pipefail

. "$HOME/.config/dotfiles/config.sh"

PACKMAN_PACKAGES=("vifm")

. "${DATA_DIR}/install.sh"
