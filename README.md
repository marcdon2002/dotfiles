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
git clone https://github.com/marcdon2002/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script will:

1. Install Xcode Command Line Tools (if needed)
2. Install [Homebrew](https://brew.sh/) (if needed)
3. Install all packages from the Brewfile
4. Install Oh My Zsh + fzf-tab plugin
5. Symlink all config files with GNU Stow
6. Install Catppuccin tmux theme
7. Install TPM and tmux plugins
8. Import the Terminal.app profile

### Already Have a Setup?

No worries — the install script **backs up** your existing config files before replacing them:

| File | Backup |
|------|--------|
| `~/.zshrc` | `~/.zshrc.backup` |
| `~/.tmux.conf` | `~/.tmux.conf.backup` |
| `~/.config/omp/1_shell.omp.json` | `~/.config/omp/1_shell.omp.json.backup` |

Already installed tools (Homebrew, Oh My Zsh, TPM, fzf-tab) are detected and skipped — only missing components get installed.

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

All config files are symlinked to their correct locations using [GNU Stow](https://www.gnu.org/software/stow/). Editing `~/.zshrc` automatically edits the file inside `~/.dotfiles/` — no manual copying needed.

## Updating

After making changes to your config:

```bash
cd ~/.dotfiles
git add -A && git commit -m "update config" && git push
```

On another Mac, pull the latest changes:

```bash
cd ~/.dotfiles && git pull
```

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
cd ~/.dotfiles
stow -D zsh tmux omp
mv ~/.zshrc.backup ~/.zshrc
mv ~/.tmux.conf.backup ~/.tmux.conf
mv ~/.config/omp/1_shell.omp.json.backup ~/.config/omp/1_shell.omp.json
```

## Credits

- [Catppuccin](https://catppuccin.com/) — Color palette
- [Oh My Posh](https://ohmyposh.dev/) — Prompt engine
- [GNU Stow](https://www.gnu.org/software/stow/) — Symlink manager
