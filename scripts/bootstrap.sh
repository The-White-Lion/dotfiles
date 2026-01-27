#!/usr/bin/env bash
set -e

# ==============================================
# Dotfiles Bootstrap Script
# Quickly restore configuration on new systems
# ==============================================

# Source libraries
SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
source "$SCRIPT_DIR/lib/platform.sh"
source "$SCRIPT_DIR/lib/dependencies.sh"

# Variables
DOTFILES="${PWD:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"

# ==============================================
# Helper Functions
# ==============================================

# Check if a command exists, print status and suggest install command if missing
check_and_suggest_install() {
  local tool=$1
  local pm=$2

  if command -v "$tool" &> /dev/null; then
    echo "  ✓ $tool"
    return 0
  else
    local install_cmd=$(get_install_command "$tool" "$pm")
    echo "  ✗ $tool not found"
    echo "    Install: $install_cmd"
    return 1
  fi
}

# Setup a tool: create symlink and/or generate config
setup_tool() {
  local tool=$1
  local link_src=$2
  local link_dest=$3
  local config_cmd=$4

  if ! command -v "$tool" &>/dev/null; then
    return
  fi

  if [[ -n "$link_src" && -n "$link_dest" ]]; then
    echo "  → Linking $tool config"
    ln -sfn "$link_src" "$link_dest"
  fi

  if [[ -n "$config_cmd" ]]; then
    echo "  → Generating $tool config"
    eval "$config_cmd"
  fi
}

# ==============================================
# Main Installation Process
# ==============================================

main() {
  # Detect platform
  local os=$(detect_os)
  local pm=$(detect_package_manager)

  echo "==> Installing dotfiles..."
  echo "    Platform: $os"
  echo "    Package manager: $pm"
  echo ""

  # Step 1: Create symbolic links
  echo "==> Creating symbolic links..."
  mkdir -p "$CONFIG_DIR"

  # Shell configs (always created)
  ln -sfn "$DOTFILES/nushell" "$CONFIG_DIR/nushell"
  ln -sfn "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

  # Editor & tools (always created)
  ln -sfn "$DOTFILES/vim" "$CONFIG_DIR/vim"
  ln -sfn "$DOTFILES/yazi" "$CONFIG_DIR/yazi"

  # Git config (optional)
  if [[ -f "$DOTFILES/git/gitconfig" ]]; then
    ln -sfn "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
  fi

  # Step 2: Check dependencies
  echo ""
  echo "==> Checking dependencies..."
  local tools=(starship mise zoxide carapace eza)
  local missing=0

  for tool in "${tools[@]}"; do
    check_and_suggest_install "$tool" "$pm" || ((missing++))
  done

  if [[ $missing -gt 0 ]]; then
    echo ""
    echo "⚠️  $missing dependency(ies) missing."
    echo "   Install them to enable all features, or continue with partial setup."
  fi

  # Step 3: Setup tools and generate configs
  echo ""
  echo "==> Setting up tools..."

  # Tool configs: format "tool|link_src|link_dest|config_cmd"
  # Empty fields skip that action
  local -a tool_configs=(
    "starship|$DOTFILES/starship|$CONFIG_DIR/starship|"
    "mise|||mise activate nu >\"$DOTFILES/nushell/mise.nu\""
    "zoxide|||zoxide init nushell >\"$DOTFILES/nushell/zoxide.nu\""
    "carapace|||carapace _carapace nushell >\"$DOTFILES/nushell/carapace.nu\""
    "eza|$DOTFILES/eza|$CONFIG_DIR/eza|"
  )

  for config in "${tool_configs[@]}"; do
    IFS='|' read -r tool src dst cmd <<< "$config"
    setup_tool "$tool" "$src" "$dst" "$cmd"
  done

  echo ""
  echo "==> Done! Restart your shell to apply changes."
}

main "$@"
