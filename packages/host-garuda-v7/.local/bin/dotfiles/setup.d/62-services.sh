#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

# shellcheck source=../../../../../../lib/logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

SYSTEMCTL_SERVICES=(
  "libvirtd.socket"
)

for service in "${SYSTEMCTL_SERVICES[@]}"; do
  if systemctl is-enabled "$service" &>/dev/null; then
    log_info "$service is already enabled."
  else
    log_info "Enabling and starting $service..."
    sudo systemctl enable --now "$service"
  fi
done
