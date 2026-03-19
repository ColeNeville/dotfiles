# Set XDG_CONFIG_HOME for setting config files consistent in mac and linux
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

# Function to add a directory to the PATH if it exists and is not already in the PATH
add_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

# Update PATH with common binary locations
add_to_path "/opt/homebrew/bin"
add_to_path "$HOME/.local/bin"

# Make PATH changes available to child processes
export PATH
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"

export CODEX_HOME="$XDG_CONFIG_HOME/codex"
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"
