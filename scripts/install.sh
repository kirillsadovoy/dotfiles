#!/bin/bash

set -euo pipefail

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/utils.sh"
. "$SCRIPT_DIR/apps-install.sh"
. "$SCRIPT_DIR/set-osx-defaults.sh"

section() {
  printf "\n"
  info "===================="
  info "$1"
  info "===================="
}

confirm() {
  local answer
  read -p "$1 [y/n] " answer
  [[ "$answer" == "y" ]]
}

info "System configuration initialized..."

if confirm "Install xcode and homebrew?"; then
  section "xcode and homebrew"
  install_xcode
  install_homebrew
fi

if confirm "Install apps from brewfile?"; then
  section "Apps"
  run_brew_bundle
fi

if confirm "Symlink dotfiles into \$HOME with stow?"; then
  section "Dotfiles (stow)"
  run_stow
fi

if confirm "Install zap (zsh plugin manager)?"; then
  section "Zap"
  install_zap
fi

if confirm "Install Node.js LTS via nvm?"; then
  section "Node.js"
  install_node
fi

if confirm "Set OSX system defaults?"; then
  section "OSX System Defaults"
  set_osx_system_defaults
fi

if confirm "Install Caps Lock -> Control system remap (LaunchDaemon)?"; then
  section "Caps Lock -> Control"
  install_caps_to_control_daemon
fi

if confirm "Point Alfred at the synced preferences folder?"; then
  section "Alfred"
  set_alfred_syncfolder
fi

success "System configuration finished."
