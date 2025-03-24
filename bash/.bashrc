# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ -f "$HOME/.config/emacs/bin" ]]; then
  PATH="$HOME/.config/emacs/bin:$PATH"
fi

export PATH

# User specific aliases and functions
mkdir ~/.bashrd.d 2> /dev/null

for rc in ~/.bashrc.d/*; do
  if [ -f "$rc" ]; then
    . "$rc"
  fi
done

unset rc

# Optional direnv setup
if [ -f "/usr/bin/direnv" ]; then
  eval "$(/usr/bin/direnv hook bash)"
fi

# GPG agent as SSH agent
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# NVM setup if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup BASH prompt
parse_git_branch(){ git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'; }

hostname_if_ssh(){
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo "[$(hostname)] "
  fi
}

export PS1='$(hostname_if_ssh)\w $(parse_git_branch)$ '
