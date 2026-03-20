# Cole Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use daily.

## Overview

This dotfiles repository uses a **modular package-based architecture** powered by GNU Stow. Each package is self-contained and can be installed independently, allowing you to pick only the configurations you need. The system supports cross-platform configurations (Linux/macOS), host-specific customizations, and optional tool packages.

## Features

- **Modular Design**: Organized into reusable packages (`common`, `os-*`, `host-*`, `extra-*`)
- **XDG Base Directory Compliant**: Follows modern Linux standards for config file locations
- **Automated Setup**: Smart setup system that installs dependencies and configures tools
- **Shell Configuration Injection**: Modular bash/zsh configuration via `bashrc.d/` and `zshrc.d/`
- **Cross-Platform**: Supports both Linux and macOS with OS-specific overrides
- **Symlink Management**: Uses GNU Stow for clean, reversible installations

## Prerequisites

- **Git**: For cloning the repository
- **GNU Stow**: For symlink management
  - macOS: `brew install stow`
  - Arch Linux: `sudo pacman -S stow`
  - Ubuntu/Debian: `sudo apt install stow`
- **Optional**: `pacman` or `homebrew` for automated package installation

## Installation

### Quick Setup

Use the automated install script:

```bash
curl -fsSL https://raw.githubusercontent.com/coleneville/dotfiles/main/scripts/install.sh | bash
source ~/.bashrc
dotfiles.sh setup
```

### Manual Setup

1. Clone the repository with submodules:

   ```bash
   git clone --recurse-submodules https://github.com/coleneville/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the install script:

   ```bash
   ./scripts/install.sh
   ```

3. Reload your shell and run setup:

   ```bash
   source ~/.bashrc  # or source ~/.zshrc if using zsh
   dotfiles.sh setup
   ```

### What Happens During Installation

1. **Validation**: Checks for required tools (git, stow)
2. **XDG Directories**: Creates standard directories (`~/.config`, `~/.local/bin`, `~/.local/share`)
3. **Stow Packages**: Symlinks all packages to your home directory
4. **Setup Scripts**: Runs `dotfiles.sh setup` to install dependencies and configure tools

## Architecture

### Package Structure

The repository is organized into modular packages under `packages/`:

- **`common/`** - Core configurations shared across all systems (git, bash, gpg)
- **`os-linux/`** - Linux-specific configurations and package installations
- **`os-macos/`** - macOS-specific configurations and Homebrew packages
- **`host-<hostname>/`** - Host-specific configurations for individual machines
- **`extra-<tool>/`** - Optional tool packages (install only what you use)

### How Packages Work

Each package mirrors your home directory structure. When you "stow" a package, GNU Stow creates symlinks from the package to your home directory:

```
packages/common/.bashrc          → ~/.bashrc
packages/common/.config/git/     → ~/.config/git/
packages/extra-nvim/.config/nvim → ~/.config/nvim
```

**XDG Base Directory Compliance**: Files are organized following modern standards:
- `~/.config/` - Configuration files
- `~/.local/bin/` - User executables
- `~/.local/share/` - User data files
- `~/.local/state/` - State/cache files

**State Tracking**: Stowed packages are tracked in `$XDG_DATA_HOME/stow/state` for easy management.

## Available Packages

### Core Packages
- **`common`** - Essential configs (git, bash, gpg, tmux plugins)

### OS-Specific Packages
- **`os-linux`** - Linux configurations and package installation scripts
- **`os-macos`** - macOS configurations and Homebrew formulas

### Host-Specific Packages
- **`host-garuda-v6`** - Configuration for garuda-v6 machine
- **`host-garuda-v7`** - Configuration for garuda-v7 machine

### Optional Tool Packages (Extra)
- **`extra-nvim`** - Neovim configuration with lazy.nvim
- **`extra-old-nvim`** - Alternative Neovim setup
- **`extra-tmux`** - Tmux configuration with TPM plugin manager
- **`extra-wezterm`** - WezTerm terminal emulator config
- **`extra-zsh`** - Zsh shell with Oh My Zsh integration
- **`extra-lazygit`** - Lazygit TUI configuration
- **`extra-vifm`** - Vifm file manager configuration
- **`extra-opencode`** - OpenCode editor settings
- **`extra-work`** - Work-specific configurations and tools

## The Setup System

### `dotfiles.sh` Command

After installation, the `dotfiles.sh` command is available in your `$PATH` (installed to `~/.local/bin/`):

```bash
dotfiles.sh setup    # Run all setup scripts
```

This command orchestrates the installation of dependencies and configuration of tools across all stowed packages.

### Setup Scripts (`setup.d/`)

Each package can contribute setup scripts that run when you execute `dotfiles.sh setup`:

**Location in packages**: `.local/bin/dotfiles/setup.d/XX-name.sh`

**How it works**:
1. Each package places numbered scripts in `setup.d/` (e.g., `00-setup.sh`, `50-install.sh`, `99-nvim.sh`)
2. When packages are stowed, these scripts are merged into `~/.local/bin/dotfiles/setup.d/`
3. Running `dotfiles.sh setup` executes all scripts in sorted order (00-99)

**Example setup scripts**:
- `00-setup.sh` (common) - Creates required directories
- `50-install.sh` (common) - Installs NVM and Node.js
- `51-install.sh` (os-linux) - Installs Linux packages via pacman
- `99-nvim.sh` (extra-nvim) - Installs Neovim dependencies
- `99-zsh.sh` (extra-zsh) - Configures Zsh and Oh My Zsh

### Shell Configuration Injection (`bashrc.d/` and `zshrc.d/`)

This system allows **any package to contribute shell configuration snippets** that are automatically loaded in a predictable order.

#### Bash Configuration

**Location in packages**: `.config/bashrc.d/XX-name.sh`

The main `.bashrc` (from the `common` package) automatically sources all files from `~/.config/bashrc.d/`:

```bash
export BASH_CONFIG_DIR=$HOME/.config/bashrc.d/
for rc in "$BASH_CONFIG_DIR"/*; do
  if [ -f "$rc" ]; then
    . "$rc"
  fi
done
```

#### Zsh Configuration

**Location in packages**: `.config/zshrc.d/XX-name.zsh`

The main `.zshrc` (from the `extra-zsh` package) follows the same pattern for `~/.config/zshrc.d/`:

```bash
export ZSH_CONFIG_DIR=$HOME/.config/zshrc.d/
for rc in "$ZSH_CONFIG_DIR"/*; do
  if [ -f "$rc" ]; then
    . "$rc"
  fi
done
```

#### Naming Convention & Load Order

Files are named with numeric prefixes to control load order:

**Examples**:
- `00-profile.sh` / `01-profile.zsh` - XDG paths, environment variables
- `10-functions.sh` / `10-functions.zsh` - Shell functions
- `20-aliases.sh` / `20-aliases.zsh` - Command aliases  
- `99-nvim.sh` / `99-nvim.zsh` - Tool-specific environment setup

This design means:
- The `os-linux` package can add Linux-specific aliases to `bashrc.d/21-aliases.sh`
- The `extra-work` package can add work functions to `bashrc.d/12-functions.sh`
- The `host-garuda-v7` package can add host-specific aliases to `bashrc.d/22-aliases.sh`
- All are automatically loaded in the correct order!

## Usage

### Managing Packages

Individual packages can be managed using the provided scripts:

```bash
cd ~/.dotfiles

# Install a specific package
./scripts/stow.sh extra-nvim

# Remove a specific package  
./scripts/unstow.sh extra-nvim

# Install all packages
./scripts/stow-all.sh

# Remove all packages
./scripts/unstow-all.sh
```

### Common Workflows

```bash
# After installing a new optional package
./scripts/stow.sh extra-lazygit
dotfiles.sh setup  # Run setup scripts for new package

# Update configurations
cd ~/.dotfiles
git pull
git submodule update --recursive --remote

# Test a package installation (dry run)
stow -n -t "$HOME" -S extra-nvim -d packages/
```

## Troubleshooting

### Stow Conflicts

If you encounter conflicts when stowing:

```bash
# Use dry-run to see what would happen
stow -n -t "$HOME" -S package-name -d packages/

# If conflicts exist, backup and remove conflicting files
mv ~/.config/conflicting-file ~/.config/conflicting-file.backup
./scripts/stow.sh package-name
```

### Verifying Installation

Check that symlinks were created correctly:

```bash
# Verify dotfiles.sh is in PATH
which dotfiles.sh

# Check stowed packages
cat ~/.local/share/stow/state

# Verify symlinks
ls -la ~/.bashrc
ls -la ~/.config/git
```

### Missing Dependencies

If setup scripts fail:

```bash
# Check logs from setup
dotfiles.sh setup

# Manually install missing tools
# For Arch Linux:
sudo pacman -S git stow neovim

# For macOS:
brew install git stow neovim
```

## Development

For detailed information on code style, conventions, and development guidelines, see [AGENTS.md](AGENTS.md).

### Adding a New Package

1. Create package directory: `packages/your-package-name/`
2. Add configuration files mirroring home directory structure
3. (Optional) Add setup script: `.local/bin/dotfiles/setup.d/50-your-package.sh`
4. (Optional) Add shell config: `.config/bashrc.d/20-your-package.sh`
5. Test: `./scripts/stow.sh your-package-name`

### Testing Changes

```bash
# Validate shell script syntax
bash -n scripts/your-script.sh

# Test stow in dry-run mode
stow -n -t "$HOME" -S package-name -d packages/

# Verify symlinks
ls -la ~/path/to/expected/symlink
```

## License

Personal dotfiles repository. Feel free to use as inspiration for your own configurations.
