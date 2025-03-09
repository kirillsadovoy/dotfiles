#!/bin/bash

. utils.sh
. apps-install.sh
. set-osx-defaults.sh

info "System configuration initialized..."
read -p "Install xcode and homebrew? [y/n] " install_base

if [[ "$install_base" == "y" ]]; then
  printf "\n"
  info "===================="
  info "xcode and homebrew"
  info "===================="

  install_xcode
  install_homebrew
fi

read -p "Install apps from brewfile? [y/n] " install_brew_bundle

if [[ "$install_brew_bundle" == "y" ]]; then
  printf "\n"
  info "===================="
  info "Apps"
  info "===================="

  run_brew_bundle
fi

read -p "Set OSX system defaults? [y/n] " set_osx_defaults

if [[ "$set_osx_defaults" == "y" ]]; then
  printf "\n"
  info "===================="
  info "OSX System Defaults"
  info "===================="

  set_osx_system_defaults
fi

success "System confiiguration finished."
