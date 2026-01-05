set -eou pipefail

PACMAN_PACKAGES=(
  "dnsmasq"
  "wofi"
  "niri"
  "qemu-full"
)

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/setup"

. "${DATA_DIR}/logging.sh"

for package in "${PACMAN_PACKAGES[@]}"; do
  if pacman -Qi "$package" &>/dev/null; then
    log_info "$package is already installed."
    PACMAN_PACKAGES=("${PACMAN_PACKAGES[@]/$package}")
  else
    log_info "Installing $package via pacman."
    sudo pacman -S --noconfirm "$package"
  fi
done
