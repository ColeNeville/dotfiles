# Cole Neville's Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use daily.

## Overview

This dotfiles repository is organized by application, with each application's configuration files stored in its own directory. The repository uses a modular approach to make it easy to install only the configurations you need.

Each primary configuration is self-contained in the `packages/` directory and is managed by `stow` to create symbolic links in the home directory. This approach keeps the dotfiles organized and easy to manage.

## Project Structure

The repository is structured as follows:

```
.
├── packages/
│   ├── bash/
│   ├── git/
│   ├── gnupg/
│   ├── lazygit/
│   ├── macos/
│   ├── neovim/
│   ├── opencode/
│   ├── tmux/
│   └── wezterm/
├── scripts/
│   ├── install.sh
│   ├── stow.sh
│   └── unstow.sh
├── .gitignore
├── .gitmessage
├── .gitmodules
└── README.md
```

- **`packages/`**: Contains the configuration files for each application, organized into subdirectories.
- **`scripts/`**: Includes helper scripts for installing, stowing, and unstowing packages.

## Installation

### Quick Setup

To quickly set up the dotfiles, you can use the automated install script. This will clone the repository and run the installation process for you.

```bash
curl -fsSL https://raw.githubusercontent.com/coleneville/dotfiles/main/scripts/install.sh | bash
```

### Manual Setup

If you prefer to set up the dotfiles manually, follow these steps:

1. **Clone the repository with submodules**:
   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git ~/.dotfiles
   ```

2. **Run the install script**:
   The install script will stow the dotfiles, creating symbolic links in your home directory.
   ```bash
   cd ~/.dotfiles
   ./scripts/install.sh
   ```

## Featured Configurations

### Neovim

My Neovim configuration uses `lazy.nvim` for package management. It's designed to be minimal and extensible.

- Basic editor settings (options, tabs, search)
- `lazy.nvim` for plugin management

### Other Configurations

- **Git**: Custom Git configuration with global ignore patterns.
- **Bash**: Custom Bash configuration with useful aliases and functions.
- **GnuPG**: GPG agent configuration for secure key management.
- **Lazygit**: Configuration for a simple terminal UI for git commands.
- **Opencode**: Configuration for the `opencode` agent.
- **Tmux**: Configuration for the `tmux` terminal multiplexer.
- **Wezterm**: Configuration for the `wezterm` terminal emulator.

## Usage

Individual configurations can be managed using the provided scripts:

```bash
cd ~/.dotfiles
./scripts/stow.sh <package-name>    # Install a specific package
./scripts/unstow.sh <package-name>  # Remove a specific package
```

Available packages: `bash`, `git`, `gnupg`, `lazygit`, `macos`, `neovim`, `opencode`, `tmux`, `wezterm`

### Updating

To update all configurations and submodules:

```bash
cd ~/.dotfiles
git pull
git submodule update --recursive --remote
```
