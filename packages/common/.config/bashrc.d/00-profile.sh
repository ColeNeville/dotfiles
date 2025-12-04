# Set XDG_CONFIG_HOME for setting config files consistent in mac and linux
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"

# Function to add a directory to the PATH if it exists and is not already in the PATH
add_to_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}

# Environment Variables
# Add Homebrew binaries to PATH
add_to_path "/opt/homebrew/bin"

# Add user's private bin directory to PATH
add_to_path "$HOME/.local/bin"

# Make PATH changes available to child processes
export PATH

export EDITOR=nvim
