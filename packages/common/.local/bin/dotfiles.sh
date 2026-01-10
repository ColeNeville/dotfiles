#!/bin/bash

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

SUB_COMMAND_HELP="Available sub-commands:
  setup      Run the dotfiles setup scripts"

sub_command="$1"

case "$sub_command" in
  setup)
    shift
    "${BIN_DIR}/setup.sh"
    ;;
  *)
    echo "$SUB_COMMAND_HELP"
    exit 1
    ;;
esac
