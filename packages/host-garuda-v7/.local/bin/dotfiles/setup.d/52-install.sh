#!/bin/bash
set -euo pipefail

# shellcheck source=../../../../../common/.config/dotfiles/config.sh
. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

PACMAN_PACKAGES=(
  "dnsmasq"
  "niri"
  "greetd"
  "qemu-full"
  "quickshell"
)
PARU_PACKAGES=(
  "dms-shell-bin"
  "greetd-dms-greeter-git"
)

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"
