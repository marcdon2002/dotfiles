# Dotfiles

> My macOS terminal setup — Catppuccin Mocha themed, managed with [GNU Stow](https://www.gnu.org/software/stow/).

[![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Catppuccin Mocha](https://img.shields.io/badge/Catppuccin-Mocha-cba6f7?style=flat)](https://catppuccin.com/)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=gnu-bash&logoColor=white)](https://ohmyz.sh/)
[![tmux](https://img.shields.io/badge/tmux-1BB91F?style=flat&logo=tmux&logoColor=white)](https://github.com/tmux/tmux)

## What's Included

| Tool | Description |
|------|-------------|
| [**Oh My Zsh**](https://ohmyz.sh/) | Zsh framework with plugins (git, z, history-substring-search) |
| [**Oh My Posh**](https://ohmyposh.dev/) | Custom prompt theme using the Catppuccin Mocha palette |
| [**tmux**](https://github.com/tmux/tmux) | Terminal multiplexer with [Catppuccin](https://github.com/catppuccin/tmux) theme (v2.1.3) |
| [**eza**](https://github.com/eza-community/eza) | Modern `ls` replacement with icons and colors |
| [**fzf**](https://github.com/junegunn/fzf) | Fuzzy finder + [fzf-tab](https://github.com/Aloxaf/fzf-tab) for tab completion with preview |
| [**fast-syntax-highlighting**](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting for Zsh |
| [**zsh-autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like command suggestions |
| **Terminal.app** | Catppuccin Mocha profile with [MesloLGS Nerd Font](https://github.com/romkatv/nerd-fonts) |

### tmux Plugins

- [TPM](https://github.com/tmux-plugins/tpm) — Plugin manager
- [Catppuccin tmux](https://github.com/catppuccin/tmux) — Theme (manually installed, v2.1.3)
- [tmux-better-mouse-mode](https://github.com/nhdaly/tmux-better-mouse-mode) — Improved scrolling
- [tmux-agent-indicator](https://github.com/accessd/tmux-agent-indicator) — AI agent status in statusbar

## Quick Start

### Prerequisites

- macOS (Apple Silicon or Intel)
- Git (comes with Xcode Command Line Tools)

### Installation

```bash
# 1. Back up existing ~/.dotfiles directory (skipped automatically if not present)
[ -d ~/.dotfiles ] && mv ~/.dotfiles ~/.dotfiles.backup && echo "Backed up ~/.dotfiles → ~/.dotfiles.backup"

# 2. Clone the repo
git clone https://github.com/marcdon2002/dotfiles.git ~/.dotfiles

# 3. Run the install script (backs up existing config files automatically)
cd ~/.dotfiles && ./install.sh
```

### What the Install Script Does

The script is fully **idempotent** — safe to run multiple times. Already installed tools are detected and skipped.

1. **Back up** existing config files (see below)
2. Install Xcode Command Line Tools (if needed)
3. Install [Homebrew](https://brew.sh/) (if needed)
4. Install all packages from the Brewfile
5. Install Oh My Zsh + fzf-tab plugin
6. Symlink all config files via GNU Stow
7. Install Catppuccin tmux theme + TPM plugins
8. Import the Terminal.app profile

### Your Existing Config is Safe

The very first thing the install script does is **back up** your existing config files — before anything gets installed or overwritten:

| What | Backed up to | When |
|------|-------------|------|
| `~/.dotfiles/` | `~/.dotfiles.backup/` | Before cloning (installation step 1) |
| `~/.zshrc` | `~/.zshrc.backup` | By install.sh (step 1) |
| `~/.tmux.conf` | `~/.tmux.conf.backup` | By install.sh (step 1) |
| `~/.config/omp/1_shell.omp.json` | `~/.config/omp/1_shell.omp.json.backup` | By install.sh (step 1) |

This works for both **regular files** and **symlinks** (e.g. from another dotfiles manager) — the actual file content is always preserved in the `.backup` file. Files that don't exist are skipped.

To restore your original config at any time, see [Uninstall](#uninstall).

### After Install

1. Open **Terminal.app → Settings → Profiles**
2. Set **Catppuccin Mocha** as default profile
3. Set font to **MesloLGS Nerd Font Mono** (size 14)
4. Restart Terminal

## File Structure

```
~/.dotfiles/
├── Brewfile                         # Homebrew packages
├── install.sh                       # Bootstrap script
├── zsh/
│   └── .zshrc                       → ~/.zshrc
├── tmux/
│   └── .tmux.conf                   → ~/.tmux.conf
├── omp/
│   └── .config/omp/
│       └── 1_shell.omp.json         → ~/.config/omp/1_shell.omp.json
└── terminal/
    └── Catppuccin-Mocha.terminal    # Terminal.app profile (imported via open)
```

All config files are symlinked to their correct locations using [GNU Stow](https://www.gnu.org/software/stow/).

## Catppuccin Mocha Colors

This setup uses the [Catppuccin Mocha](https://catppuccin.com/) palette across all tools:

| Color | Hex | Usage |
|-------|-----|-------|
| Base | `#1E1E2E` | Terminal background |
| Text | `#CDD6F4` | Default text |
| Pink | `#F5C2E7` | Username, path |
| Mauve | `#CBA6F7` | Git branch, accents |
| Blue | `#89B4FA` | Path highlights |
| Lavender | `#B4BEFE` | Time |
| Teal | `#94E2D5` | Status OK |
| Red | `#F38BA8` | Status error |

## Uninstall

Remove the symlinks and restore everything to its previous state:

```bash
# 1. Remove symlinks
cd ~ && stow -D -d .dotfiles zsh tmux omp

# 2. Restore config file backups
mv ~/.zshrc.backup ~/.zshrc 2>/dev/null
mv ~/.tmux.conf.backup ~/.tmux.conf 2>/dev/null
mv ~/.config/omp/1_shell.omp.json.backup ~/.config/omp/1_shell.omp.json 2>/dev/null

# 3. Remove the cloned repo
rm -rf ~/.dotfiles

# 4. Restore your previous ~/.dotfiles directory (if it was backed up during installation)
[ -d ~/.dotfiles.backup ] && mv ~/.dotfiles.backup ~/.dotfiles && echo "Restored ~/.dotfiles.backup → ~/.dotfiles"
```

> **Note:** Steps 2 and 4 only restore files that were actually backed up during installation. If no backup exists (e.g. on a fresh Mac), those steps are simply skipped — `2>/dev/null` suppresses any errors.

## Credits

- [Catppuccin](https://catppuccin.com/) — Color palette
- [Oh My Posh](https://ohmyposh.dev/) — Prompt engine
- [GNU Stow](https://www.gnu.org/software/stow/) — Symlink manager
