#!/bin/bash

set -eou pipefail

. "${HOME}/.config/dotfiles/config.sh"

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

. "${DATA_DIR}/install.sh"
