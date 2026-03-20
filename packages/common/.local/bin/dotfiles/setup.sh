#!/bin/bash

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

# shellcheck source=../../../../../../lib/logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

for setup_script in "${SETUP_SCRIPT_DIR}"/*.sh; do
  if [ -f "$setup_script" ]; then
    log_info "Executing setup script: $setup_script"
    bash "$setup_script"
  fi
done
