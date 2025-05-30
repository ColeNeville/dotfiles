# ~/.bash_profile: Executed by bash for login shells
# Sets up environment variables and sources .bashrc

# Add Homebrew binaries to PATH if directory exists and not already in PATH
if [ -d "/opt/homebrew/bin" ] && ! [[ "$PATH" =~ "/opt/homebrew/bin:" ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

# Add user's private bin directory to PATH if it exists and not already in PATH
if [ -d "$HOME/.local/bin" ] && ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Make PATH changes available to child processes
export PATH

# Load .bashrc for interactive shell settings (aliases, functions, etc.)
source ~/.bashrc
