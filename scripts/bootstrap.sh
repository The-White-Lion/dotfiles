#!/usr/bin/env bash
set -euo pipefail

# ==============================================
# Dotfiles Bootstrap Script
# Quickly restore configuration on new systems
# ==============================================

# Source libraries
SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
source "$SCRIPT_DIR/lib/platform.sh"

# Variables
DOTFILES="${PWD:-$HOME/dotfiles}"
CONFIG_DIR="$HOME/.config"

# ==============================================
# Helper Functions
# ==============================================

# Check if a command exists
check_tool() {
  local tool=$1

  if command -v "$tool" &> /dev/null; then
    echo "  ✓ $tool"
    return 0
  else
    echo "  ✗ $tool (not found)"
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

# Copy Nushell configs to target directory (used on macOS)
sync_nushell_config() {
  local src_dir=$1
  local dest_dir=$2

  mkdir -p "$dest_dir"

  # Keep copy scope explicit to avoid overwriting local runtime artifacts.
  local files=(
    "config.nu"
    "env.nu"
    "mise.nu"
    "zoxide.nu"
    "carapace.nu"
  )

  for file in "${files[@]}"; do
    if [[ -f "$src_dir/$file" ]]; then
      cp "$src_dir/$file" "$dest_dir/$file"
    fi
  done

  if [[ -d "$src_dir/vendor" ]]; then
    mkdir -p "$dest_dir/vendor"
    cp -R "$src_dir/vendor/." "$dest_dir/vendor/"
  fi
}

# ==============================================
# Main Installation Process
# ==============================================

main() {
  # Detect platform
  local os=$(detect_os)
  local pm=$(detect_package_manager)
  local nu_config_dir=$(detect_nushell_config_dir)
  local nu_generated_base="$DOTFILES/nushell"

  echo "==> Installing dotfiles..."
  echo "    Platform: $os"
  echo "    Package manager: $pm"
  echo "    Nushell config dir: $nu_config_dir"
  echo ""

  # Step 1: Create symbolic links
  echo "==> Creating symbolic links..."
  mkdir -p "$CONFIG_DIR"
  mkdir -p "$(dirname "$nu_config_dir")"

  # Nushell config: platform-aware path
  if [[ "$os" == "macos" ]]; then
    echo "  → Copying Nushell config to $nu_config_dir"
    sync_nushell_config "$DOTFILES/nushell" "$nu_config_dir"
    nu_generated_base="$nu_config_dir"

    # Keep ~/.config/nushell as compatibility path for tools/scripts
    ln -sfn "$nu_config_dir" "$CONFIG_DIR/nushell"
  else
    ln -sfn "$DOTFILES/nushell" "$nu_config_dir"
    # Keep ~/.config/nushell as compatibility path for tools/scripts
    ln -sfn "$DOTFILES/nushell" "$CONFIG_DIR/nushell"
  fi

  # Shell configs (always created)
  ln -sfn "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

  # Editor & tools (always created)
  ln -sfn "$DOTFILES/nvim" "$CONFIG_DIR/nvim"
  ln -sfn "$DOTFILES/yazi" "$CONFIG_DIR/yazi"
  ln -sfn "$DOTFILES/ghostty" "$CONFIG_DIR/ghostty"

  # Git config (optional)
  if [[ -f "$DOTFILES/git/gitconfig" ]]; then
    ln -sfn "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
  fi

  # Step 2: Check dependencies
  echo ""
  echo "==> Checking dependencies..."
  local tools=(starship mise zoxide carapace eza yazi nvim)
  local missing=0

  for tool in "${tools[@]}"; do
    check_tool "$tool" || missing=$((missing + 1))
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
  # Empty fields skip that action bat -p --color=always
  local -a tool_configs=(
    "starship|$DOTFILES/starship|$CONFIG_DIR/starship|mkdir -p \"$nu_generated_base/vendor/autoload\" && starship init nu >\"$nu_generated_base/vendor/autoload/starship.nu\""
    "mise|||mise activate nu >\"$nu_generated_base/mise.nu\""
    "zoxide|||zoxide init nushell >\"$nu_generated_base/zoxide.nu\""
    "carapace|||carapace _carapace nushell >\"$nu_generated_base/carapace.nu\""
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
