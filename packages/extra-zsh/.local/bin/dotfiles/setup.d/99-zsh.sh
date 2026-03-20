#!/bin/bash
set -euo pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"

PACMAN_PACKAGES=("zsh")
HOMEBREW_PACKAGES=("zsh")

# shellcheck source=../../../../../../lib/install.sh
. "${DOTFILES_DIR}/lib/install.sh"

# shellcheck source=../../../../../../lib/logging.sh
. "${DOTFILES_DIR}/lib/logging.sh"

log_info "Changing default shell to zsh"
sudo chsh "${USER}" --shell /bin/zsh

# Note: Oh My Zsh will be installed automatically on first terminal launch
# via the 00-oh-my-zsh.zsh configuration file in ~/.config/zshrc.d/
