#!/bin/bash

SETUP_CONFIG_DIR="${XDG_CONFIG_HOME}/setup.d"
SETUP_DATA_DIR="${XDG_DATA_HOME}/setup"

. "${SETUP_DATA_DIR}/logging.sh"

for setup_script in "${SETUP_CONFIG_DIR}"/*.sh; do
  if [ -f "$setup_script" ]; then
    log_info "Executing setup script: $setup_script"
    bash "$setup_script"
  fi
done
