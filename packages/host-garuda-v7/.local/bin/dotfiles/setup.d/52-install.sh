#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

PACMAN_PACKAGES=(
  "dnsmasq"
  "niri"
  "greetd"
  "qemu-full"
)
PARU_PACKAGES=(
  "dms-shell-bin"
  "greetd-dms-greeter-git"
)

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"
