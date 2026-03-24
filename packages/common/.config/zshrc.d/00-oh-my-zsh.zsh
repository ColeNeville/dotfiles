# Oh My Zsh configuration
# This file is loaded first (00 prefix) to initialize Oh My Zsh before other configurations

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh not found. Installing..."
  
  # Create temporary files for downloads
  OH_MY_ZSH_GITHUB=$(mktemp)
  OH_MY_ZSH_MIRROR=$(mktemp)
  
  # Download from both sources
  echo "Downloading Oh My Zsh install script from GitHub..."
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh > "${OH_MY_ZSH_GITHUB}"
  
  echo "Downloading Oh My Zsh install script from official mirror..."
  curl -fsSL https://install.ohmyz.sh > "${OH_MY_ZSH_MIRROR}"
  
  # Verify hash integrity
  echo "Verifying install script integrity..."
  GITHUB_HASH=$(sha256sum "${OH_MY_ZSH_GITHUB}" | cut -d' ' -f1)
  MIRROR_HASH=$(sha256sum "${OH_MY_ZSH_MIRROR}" | cut -d' ' -f1)
  
  echo "GitHub hash: ${GITHUB_HASH}"
  echo "Mirror hash: ${MIRROR_HASH}"
  
  if [ "$GITHUB_HASH" != "$MIRROR_HASH" ]; then
    echo "ERROR: Oh My Zsh install script hash mismatch between sources!"
    echo "This could indicate a security issue. Aborting installation."
    rm -f "${OH_MY_ZSH_GITHUB}" "${OH_MY_ZSH_MIRROR}"
    return 1
  fi
  
  echo "Hash verification successful"
  rm -f "${OH_MY_ZSH_MIRROR}"
  
  # Run Oh My Zsh installation (automated, non-interactive)
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh "${OH_MY_ZSH_GITHUB}"
  
  # Cleanup
  rm -f "${OH_MY_ZSH_GITHUB}"
  
  echo "Oh My Zsh installation complete!"
  echo "Please restart your terminal or run 'source ~/.zshrc' to load Oh My Zsh."
fi

# Load Oh My Zsh if installed
if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="robbyrussell"
  plugins=(git)
  
  source $ZSH/oh-my-zsh.sh
fi
