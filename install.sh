#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"

echo "=== Dotfiles Setup ==="

# 1. Backup existing config files (before anything gets installed or overwritten)
echo "Backing up existing config files..."
for f in "$HOME/.zshrc" "$HOME/.tmux.conf" "$HOME/.config/omp/1_shell.omp.json"; do
  if [ -L "$f" ]; then
    cp -L "$f" "$f.backup" && echo "  Backed up (symlink target): $f"
    rm "$f"
  elif [ -f "$f" ]; then
    mv "$f" "$f.backup" && echo "  Backed up: $f"
  else
    echo "  No existing file found: $f (nothing to back up)"
  fi
done

# 2. Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Press any key after the installation is complete..."
  read -n 1 -s
fi

# 3. Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 4. Brew packages
echo "Installing brew packages..."
brew bundle --verbose --file="$DOTFILES/Brewfile"

# 5. Oh My Zsh (KEEP_ZSHRC=yes prevents overwriting our stowed .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  rm -f "$HOME/.zshrc"
fi

# 6. fzf-tab plugin
FZF_TAB="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"
if [ ! -d "$FZF_TAB" ]; then
  echo "Installing fzf-tab..."
  git clone --depth 1 https://github.com/Aloxaf/fzf-tab "$FZF_TAB"
fi

# 7. Link dotfiles with stow
echo "Linking dotfiles with stow..."
mkdir -p "$HOME/.config/omp"
for pkg in zsh tmux omp; do
  stow --restow -d "$DOTFILES" -t "$HOME" "$pkg"
done

# 8. Catppuccin for tmux (manual install)
CATPPUCCIN_DIR="$HOME/.config/tmux/plugins/catppuccin/tmux"
if [ ! -d "$CATPPUCCIN_DIR" ]; then
  echo "Installing Catppuccin tmux theme..."
  mkdir -p "$(dirname "$CATPPUCCIN_DIR")"
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$CATPPUCCIN_DIR"
fi

# 9. TPM plugins
TPM_BASE="$(brew --prefix tpm)/share/tpm"
echo "Installing tmux plugins..."
"$TPM_BASE/bin/install_plugins" || true

# 10. Terminal.app profile
TERMINAL_PROFILE="$DOTFILES/terminal/Catppuccin-Mocha.terminal"
if [ -f "$TERMINAL_PROFILE" ]; then
  echo "Importing Terminal.app profile..."
  open "$TERMINAL_PROFILE"
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Manual steps:"
echo "  1. Set 'Catppuccin Mocha' as default profile in Terminal → Settings → Profiles"
echo "  2. Set font to 'MesloLGS Nerd Font Mono' (size 14)"
echo "  3. Restart Terminal"
echo "  4. Run 'exec zsh' to reload your shell"
echo "  5. Run 'tmux' to start tmux"
