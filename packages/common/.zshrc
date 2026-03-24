# ~/.zshrc: Executed by zsh for interactive shells
# Contains settings for interactive shell behavior, aliases, functions, and prompt customization
# This file is sourced automatically for all interactive zsh shells

export ZSH_CONFIG_DIR=$HOME/.config/zshrc.d/

# Load all script files from $ZSH_CONFIG_DIR directory
# This allows for modular organization of zsh configurations
# and injection via other stow packages
for rc in "$ZSH_CONFIG_DIR"/*; do
  if [ -f "$rc" ]; then
    . "$rc"
  fi
done

unset rc

# Initialize direnv if available in PATH
# direnv allows for environment variable management on a per-directory basis
# It automatically loads/unloads environment variables depending on the current directory
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Configure GPG agent to act as SSH agent
# This allows using GPG keys for SSH authentication
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Node Version Manager (NVM) setup if available
# NVM allows managing multiple Node.js versions on the same machine
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm

[ -s "$HOME/.rbenv/bin/rbenv" ] && eval "$("$HOME"/.rbenv/bin/rbenv init - --no-rehash zsh)"

# TODO: Migrate tool integrations to Oh My Zsh plugins
# - direnv: Use oh-my-zsh direnv plugin
# - NVM: Use oh-my-zsh nvm plugin (also handles completion)
# - rbenv: Use oh-my-zsh rbenv plugin
# Once migrated, remove the manual setup above and keep only GPG/SSH config


