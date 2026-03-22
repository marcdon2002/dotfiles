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
# 1. Clone the repo
git clone https://github.com/marcdon2002/dotfiles.git ~/.dotfiles

# 2. Navigate into the repo
cd ~/.dotfiles

# 3. Run the install script (automatically backs up your existing configs first)
./install.sh
```

> **Note:** If `~/.dotfiles` already exists, back it up first: `mv ~/.dotfiles ~/.dotfiles.old`

### What the Install Script Does

The script is fully **idempotent** — you can run it multiple times without breaking anything. Already installed tools are detected and skipped.

1. **Backup** existing config files (see below)
2. Install Xcode Command Line Tools (if needed)
3. Install [Homebrew](https://brew.sh/) (if needed)
4. Install all packages from the Brewfile
5. Install Oh My Zsh + fzf-tab plugin
6. Symlink all config files with GNU Stow
7. Install Catppuccin tmux theme + TPM plugins
8. Import the Terminal.app profile

### Your Existing Config is Safe

The **very first thing** the install script does is back up your existing config files — before anything gets installed or overwritten:

| Your file | Backed up to |
|-----------|-------------|
| `~/.zshrc` | `~/.zshrc.backup` |
| `~/.tmux.conf` | `~/.tmux.conf.backup` |
| `~/.config/omp/1_shell.omp.json` | `~/.config/omp/1_shell.omp.json.backup` |

This works for both **regular files** and **symlinks** (e.g. from another dotfiles manager) — the actual file content is always preserved in the `.backup` file.

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
├── README.md
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

Remove the symlinks and restore your original config:

```bash
# 1. Remove symlinks
cd ~/.dotfiles
stow -D zsh tmux omp

# 2. Restore your backed-up config files (if they exist)
mv ~/.zshrc.backup ~/.zshrc
mv ~/.tmux.conf.backup ~/.tmux.conf
mv ~/.config/omp/1_shell.omp.json.backup ~/.config/omp/1_shell.omp.json
```

> **Note:** The `mv` commands in step 2 will only work if the install script created a backup for that file. If you get a "No such file or directory" error, it simply means that file didn't exist before the installation — you can safely ignore it.

If you also want to remove the repo itself: `rm -rf ~/.dotfiles`

## Credits

- [Catppuccin](https://catppuccin.com/) — Color palette
- [Oh My Posh](https://ohmyposh.dev/) — Prompt engine
- [GNU Stow](https://www.gnu.org/software/stow/) — Symlink manager
