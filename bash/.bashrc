# ~/.bashrc: Executed by bash for interactive non-login shells
# Contains settings for interactive shell behavior, aliases, functions, and prompt customization
# This file is sourced by .bash_profile for login shells and directly for non-login interactive shells

# Load all script files from ~/.bashrc.d/ directory
# This allows for modular organization of bash configurations
for rc in ~/.bashrc.d/*; do
  if [ -f "$rc" ]; then
    . "$rc"
  fi
done

unset rc

# Initialize direnv if available in PATH
# direnv allows for environment variable management on a per-directory basis
# It automatically loads/unloads environment variables depending on the current directory
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# Configure GPG agent to act as SSH agent
# This allows using GPG keys for SSH authentication
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Node Version Manager (NVM) setup if available
# NVM allows managing multiple Node.js versions on the same machine
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Custom BASH prompt configuration
# Displays useful information in the command prompt

# Function to extract and format the current git branch for display in prompt
# Returns the current branch name in parentheses followed by a space, or empty string if not in a git repository
parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'; }

# Function to display hostname in prompt only when connected via SSH
# This helps visually distinguish SSH sessions from local terminal sessions
hostname_if_ssh(){
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "[$(hostname)] "
  fi
}

# Set the primary prompt string (PS1)
# Format: [username@hostname] current_directory (git_branch) $
export PS1='[$USER@$(hostname)] \w $(parse_git_branch)$ '
