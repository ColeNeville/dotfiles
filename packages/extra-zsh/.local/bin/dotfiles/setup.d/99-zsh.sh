#!/bin/bash

PACMAN_PACKAGES=("zsh")
HOMEBREW_PACKAGES=("zsh")

. "${DATA_DIR}/install.sh"

. "${DATA_DIR}/logging.sh"

log_info "Changing default shell to zsh"
sudo chsh "${USER}" --shell /bin/zsh

# Note: Oh My Zsh will be installed automatically on first terminal launch
# via the 00-oh-my-zsh.zsh configuration file in ~/.config/zshrc.d/
