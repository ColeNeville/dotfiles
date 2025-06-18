# Cole Neville's Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use daily.

## Overview

This dotfiles repository is organized by application, with each application's configuration files stored in its own directory. The repository uses a modular approach to make it easy to install only the configurations you need.

## Installation

### Quick Setup

Use the automated install script:

```bash
curl -fsSL https://raw.githubusercontent.com/coleneville/dotfiles/main/install.sh | bash
```

### Manual Setup

1. Clone the repository with submodules:
   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git
   ```

2. Run the install script:
   ```bash
   cd dotfiles
   ./install.sh
   ```

## Featured Configurations

### Doom Emacs

My Doom Emacs configuration is a literate configuration written in Org mode. It includes:

- Personal information setup
- UI customization with Gruvbox theme and CaskaydiaCove Nerd Font
- Org mode and Org Roam configuration
- Development tools configuration for various languages
- LSP integration with breadcrumb navigation
- Debugging setup for Ruby applications
- AI assistance with Aider integration

### Neovim

My Neovim configuration uses `lazy.nvim` for package management. It's designed to be minimal and extensible.

- Basic editor settings (options, tabs, search)
- `lazy.nvim` for plugin management

### Other Configurations

- **Git**: Custom Git configuration with global ignore patterns
- **Bash**: Custom Bash configuration with useful aliases and functions
- **GnuPG**: GPG agent configuration for secure key management

## Usage

Individual configurations can be managed using the provided scripts:

```bash
cd dotfiles
./stow.sh package-name    # Install a specific package
./unstow.sh package-name  # Remove a specific package
```

Available packages: `aider`, `bash`, `emacs`, `git`, `gnupg`, `macos`, `neovim`, `tmux`, `toolbx`, `wezterm`

### Updating

To update all configurations and submodules:

```bash
cd ~/dotfiles
git pull
git submodule update --recursive --remote
```

If you've made changes to the Doom Emacs configuration:

```bash
~/.config/emacs/bin/doom sync
```

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

- **Name**: Cole Neville
- **Email**: <me@coleneville.net>
