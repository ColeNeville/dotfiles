set -eou pipefail

. "${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/config.sh"
. "${DATA_DIR}/logging.sh"

PACMAN_PACKAGES=(
  "dnsmasq"
  "wofi"
  "niri"
  "qemu-full"
)

for package in "${PACMAN_PACKAGES[@]}"; do
  if pacman -Qi "$package" &>/dev/null; then
    log_info "$package is already installed."
    PACMAN_PACKAGES=("${PACMAN_PACKAGES[@]/$package}")
  else
    log_info "Installing $package via pacman."
    sudo pacman -S --noconfirm "$package"
  fi
done
