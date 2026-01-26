#!/usr/bin/env bash

# Dependency definitions for dotfiles bootstrap script
# Maps tools to their installation commands for different package managers

# Homebrew (macOS and Linux)
declare -A DEPS_BREW=(
  [starship]="brew install starship"
  [mise]="brew install mise"
  [zoxide]="brew install zoxide"
  [carapace]="brew install carapace"
  [eza]="brew install eza"
)

# APT (Debian/Ubuntu)
declare -A DEPS_APT=(
  [starship]="curl -sS https://starship.rs/install.sh | sh"
  [mise]="curl https://mise.jdx.dev/install.sh | sh"
  [zoxide]="cargo install zoxide"
  [carapace]="cargo install carapace"
  [eza]="cargo install eza"
)

# Pacman (Arch Linux)
declare -A DEPS_PACMAN=(
  [starship]="sudo pacman -S starship"
  [mise]="yay -S mise"
  [zoxide]="sudo pacman -S zoxide"
  [carapace]="yay -S carapace-bin"
  [eza]="sudo pacman -S eza"
)

# APK (Alpine Linux)
declare -A DEPS_APK=(
  [starship]="curl -sS https://starship.rs/install.sh | sh"
  [mise]="curl https://mise.jdx.dev/install.sh | sh"
  [zoxide]="cargo install zoxide"
  [carapace]="cargo install carapace"
  [eza]="cargo install eza"
)

# Get installation command for a tool based on package manager
get_install_command() {
  local tool=$1
  local pm=$2

  case "$pm" in
    brew) echo "${DEPS_BREW[$tool]}" ;;
    apt) echo "${DEPS_APT[$tool]}" ;;
    pacman) echo "${DEPS_PACMAN[$tool]}" ;;
    apk) echo "${DEPS_APK[$tool]}" ;;
    *) echo "# Unknown package manager. Visit https://starship.rs, https://mise.jdx.dev for manual install" ;;
  esac
}
