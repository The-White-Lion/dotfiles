#!/usr/bin/env bash

set -e

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/platform.sh"
source "$SCRIPT_DIR/lib/dependencies.sh"

DOTFILES="$PWD"
CONFIG_DIR="$HOME/.config"

# Detect platform
OS=$(detect_os)
PM=$(detect_package_manager)

echo "==> Installing dotfiles..."
echo "    Platform: $OS"
echo "    Package manager: $PM"

# Create symbolic links
echo "==> Creating symbolic links..."
mkdir -p "$CONFIG_DIR"
# shell
ln -sfn "$DOTFILES/nushell" "$CONFIG_DIR/nushell"
ln -sfn "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES/starship" "$CONFIG_DIR/starship"
# tools
ln -sfn "$DOTFILES/vim" "$CONFIG_DIR/vim"
ln -sfn "$DOTFILES/yazi" "$CONFIG_DIR/yazi"
ln -sfn "$DOTFILES/eza" "$CONFIG_DIR/eza"
if [ -f "$DOTFILES/git/gitconfig" ]; then
  ln -sfn "$DOTFILES/git/gitconfig" ~/.gitconfig
fi

# Check dependencies and suggest install if missing
echo "==> Checking dependencies..."

check_and_suggest_install() {
  local tool=$1
  if ! command -v "$tool" &> /dev/null; then
    local install_cmd=$(get_install_command "$tool" "$PM")
    echo "  ❌ $tool not found"
    echo "     Install: $install_cmd"
    return 1
  else
    echo "  ✓ $tool"
    return 0
  fi
}

# Check each tool
MISSING_DEPS=0
check_and_suggest_install starship || MISSING_DEPS=$((MISSING_DEPS + 1))
check_and_suggest_install mise || MISSING_DEPS=$((MISSING_DEPS + 1))
check_and_suggest_install zoxide || MISSING_DEPS=$((MISSING_DEPS + 1))
check_and_suggest_install carapace || MISSING_DEPS=$((MISSING_DEPS + 1))
check_and_suggest_install eza || MISSING_DEPS=$((MISSING_DEPS + 1))

if [ $MISSING_DEPS -gt 0 ]; then
  echo ""
  echo "⚠️  $MISSING_DEPS dependency(ies) missing. Install them and re-run bootstrap."
  echo "   Or skip and continue (some configs won't be generated)."
fi

# Generate nushell plugin configs
echo ""
echo "==> Generating nushell plugin configs..."

# starship
if command -v starship &>/dev/null; then
  echo "  → Generating starship.nu"
  mkdir -p "$DOTFILES/nushell/vendor/autoload"
  starship init nu >"$DOTFILES/nushell/vendor/autoload/starship.nu"
fi

# mise
if command -v mise &>/dev/null; then
  echo "  → Generating mise.nu"
  mise activate nu >"$DOTFILES/nushell/mise.nu"
fi

# zoxide
if command -v zoxide &>/dev/null; then
  echo "  → Generating zoxide.nu"
  zoxide init nushell >"$DOTFILES/nushell/zoxide.nu"
fi

# carapace
if command -v carapace &>/dev/null; then
  echo "  → Generating carapace.nu"
  carapace _carapace nushell >"$DOTFILES/nushell/carapace.nu"
fi

echo ""
echo "==> Done! Restart your shell to apply changes."
