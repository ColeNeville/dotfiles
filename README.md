# Cole Neville's Dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications I use daily.

## Overview

This dotfiles repository is organized by application, with each application's configuration files stored in its own directory. The repository uses a modular approach to make it easy to install only the configurations you need.

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

1. Install Doom Emacs following the [official instructions](https://github.com/doomemacs/doomemacs#install)
2. Clone this repository:
   ```bash
   git clone https://github.com/coleneville/dotfiles.git
   ```
3. Symlink the Doom Emacs configuration:
   ```bash
   ln -s ~/dotfiles/doom-emacs/.config/doom ~/.config/doom
   ```
4. Run Doom sync:
   ```bash
   doom sync
   ```

### Other Configurations

- **Git**: Custom Git configuration with global ignore patterns
- **Bash**: Custom Bash configuration with useful aliases and functions
- **GnuPG**: GPG agent configuration for secure key management

## Usage

You can use GNU Stow to manage the symlinks for each configuration:

```bash
cd dotfiles
stow doom-emacs  # Creates symlinks for Doom Emacs configuration
stow git         # Creates symlinks for Git configuration
# etc.
```

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

- **Name**: Cole Neville
- **Email**: me@coleneville.net
