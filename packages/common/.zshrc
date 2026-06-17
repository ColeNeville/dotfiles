# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/home/cole/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

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



# qlty
export QLTY_INSTALL="$HOME/.qlty"
export PATH="$QLTY_INSTALL/bin:$PATH"

# AI Assistant Server Access Framework
alias servers='./.agents/scripts/servers-helper.sh'
alias servers-list='./.agents/scripts/servers-helper.sh list'
alias hostinger='./.agents/scripts/hostinger-helper.sh'
alias hetzner='./.agents/scripts/hetzner-helper.sh'
alias aws-helper='./.agents/scripts/aws-helper.sh'

# >>> aidevops terminal-title integration >>>
# Sync terminal tab title with git repo/branch (works with Oh-My-Zsh)
# Falls back to directory when not in a git repo
_aidevops_terminal_title() {
    local title=""
    if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
        local repo branch
        repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
        branch=$(git branch --show-current 2>/dev/null)
        if [[ -n "$repo" ]] && [[ -n "$branch" ]]; then
            title="${repo}/${branch}"
        elif [[ -n "$repo" ]]; then
            title="$repo"
        fi
    fi
    if [[ -n "$title" ]]; then
        print -Pn "\e]0;${title}\a"
    fi
    return 0
}

# Override Oh-My-Zsh title variables to use our function
if [[ -n "${ZSH_VERSION:-}" ]] && [[ "${DISABLE_AUTO_TITLE:-}" != "true" ]]; then
    # Hook into precmd to set title after Oh-My-Zsh
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _aidevops_terminal_title
fi
# <<< aidevops terminal-title integration <<<
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/home/cole/.bun/_bun" ] && source "/home/cole/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
