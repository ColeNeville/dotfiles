. "${DATA_DIR}/logging.sh"

PACMAN_PACKAGES=(
  # Neovim itself
  "neovim"

  # Language servers and tools
  "git"
  "make"
  "unzip"
  "gcc" # GNU Compiler Collection
  "ripgrep"  # ripgrep
  "fd"  # fd-find
)

HOMEBREW_PACKAGES=(
  # Neovim itself
  "neovim"

  # Language servers and tools
  "git"
  "make"
  "unzip"
  "gcc" # GNU Compiler Collection
  "ripgrep"
  "fd"
)

. "${DATA_DIR}/install.sh"
