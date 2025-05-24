# Cole Neville's Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use daily.

## Overview

This dotfiles repository is organized by application, with each application's configuration files stored in its own directory. The repository uses a modular approach to make it easy to install only the configurations you need.

## Initial Setup

To get started with this dotfiles repository:

1. Clone the repository with submodules:
   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git
   ```

   Or if you've already cloned the repository without submodules:
   ```bash
   git clone https://github.com/coleneville/dotfiles.git
   cd dotfiles
   git submodule update --init --recursive
   ```

2. Install GNU Stow if you don't have it already:
   ```bash
   # On Fedora/RHEL
   sudo dnf install stow
   
   # On Debian/Ubuntu
   sudo apt install stow
   
   # On macOS with Homebrew
   brew install stow
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

#### Installation

1. Install Emacs (version 28.1+ recommended):
   ```bash
   # On Fedora/RHEL
   sudo dnf install emacs
   
   # On Debian/Ubuntu
   sudo apt install emacs
   
   # On macOS with Homebrew
   brew install emacs-plus
   ```

2. Clone this repository with submodules (if you haven't already):
   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git
   ```

3. Use GNU Stow to create symlinks for the Doom Emacs configuration:
   ```bash
   cd ~/dotfiles
   stow doom-emacs
   ```

4. Run Doom sync to install packages and generate configuration files:
   ```bash
   ~/.config/emacs/bin/doom sync
   ```

5. Restart Emacs to apply all changes

### Neovim

My Neovim configuration uses `lazy.nvim` for package management. It's designed to be minimal and extensible.

- Basic editor settings (options, tabs, search)
- `lazy.nvim` for plugin management

#### Installation

1. Install Neovim (version 0.8+ recommended, 0.9+ for some newer plugin features):
   ```bash
   # On Fedora/RHEL
   sudo dnf install neovim

   # On Debian/Ubuntu
   sudo apt install neovim

   # On macOS with Homebrew
   brew install neovim
   ```

2. Clone this repository with submodules (if you haven't already):
   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git
   ```

3. Use GNU Stow to create symlinks for the Neovim configuration:
   ```bash
   cd ~/dotfiles # Or wherever you cloned the repository
   stow neovim
   ```

4. Launch Neovim. `lazy.nvim` will automatically install any specified plugins on the first run.

### Other Configurations

- **Git**: Custom Git configuration with global ignore patterns
- **Bash**: Custom Bash configuration with useful aliases and functions
- **GnuPG**: GPG agent configuration for secure key management

## Usage

You can use GNU Stow to manage the symlinks for each configuration:

```bash
cd dotfiles
stow doom-emacs  # Creates symlinks for Doom Emacs configuration
stow neovim      # Creates symlinks for Neovim configuration
stow git         # Creates symlinks for Git configuration
stow bash        # Creates symlinks for Bash configuration
stow gnupg       # Creates symlinks for GnuPG configuration
# etc.
```

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
- **Email**: me@coleneville.net
