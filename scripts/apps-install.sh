#!/bin/bash

set -euo pipefail

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

. "$SCRIPT_DIR/utils.sh"

install_xcode() {
  info "Installing Apple's CLI tools (prerequisites for Git and Homebrew)..."
  if xcode-select -p &>/dev/null; then
    warning "xcode CLI tools are already installed"
  else
    xcode-select --install
    info "Confirm the GUI dialog; waiting for the installation to finish..."
    until xcode-select -p &>/dev/null; do
      sleep 5
    done
  fi
}

install_homebrew() {
  info "Installing Homebrew..."
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  # A fresh install is not on PATH yet — pick up an existing one first
  if ! hash brew &>/dev/null && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  if hash brew &>/dev/null; then
    warning "Homebrew already installed"
  else
    sudo --validate
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

run_brew_bundle() {
  local brewfile="$DOTFILES_DIR/Brewfile"
  if [ ! -f "$brewfile" ]; then
    error "Brewfile not found"
    return 1
  fi
  if grep -q '^mas ' "$brewfile"; then
    if ! command -v mas &>/dev/null || ! mas account &>/dev/null; then
      warning "Brewfile contains Mac App Store apps — make sure you are signed in to the App Store, or they will fail to install."
    fi
  fi
  if brew bundle check --file="$brewfile" &>/dev/null; then
    warning "The Brewfile's dependencies are already satisfied."
  else
    info "Satisfying missing dependencies with 'brew bundle install'..."
    brew bundle install --file="$brewfile" --verbose </dev/null || warning "brew bundle finished with errors — check the output above."
  fi
}

run_stow() {
  info "Symlinking dotfiles into \$HOME with stow..."
  # Back up pre-existing real files that would conflict with the symlinks
  local f
  for f in "$HOME/.zshrc" "$HOME/.gitconfig" "$HOME/.config/git/allowed_signers" "$HOME/.config/git/ignore"; do
    if [ -f "$f" ] && [ ! -L "$f" ]; then
      warning "Backing up existing $f to $f.pre-dotfiles"
      mv "$f" "$f.pre-dotfiles"
    fi
  done
  (cd "$DOTFILES_DIR" && stow --restow --target="$HOME" .)
}

install_zap() {
  info "Installing zap (zsh plugin manager)..."
  if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ]; then
    warning "zap is already installed"
  else
    # --keep leaves our stowed .zshrc in place instead of generating a new one
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
  fi
}

install_node() {
  info "Installing Node.js LTS via nvm..."
  if [ ! -s /opt/homebrew/opt/nvm/nvm.sh ]; then
    error "nvm is not installed (it comes from the Brewfile — run brew bundle first)"
    return 1
  fi
  export NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"
  # nvm is not `set -eu` clean — relax the flags in a subshell while it runs
  (
    set +eu
    . /opt/homebrew/opt/nvm/nvm.sh
    if [ "$(nvm version default 2>/dev/null)" != "N/A" ] && [ -n "$(nvm version default 2>/dev/null)" ]; then
      warning "Node $(nvm version default) is already set as the default"
    else
      nvm install --lts
      nvm alias default 'lts/*'
    fi
  )
}

set_alfred_syncfolder() {
  info "Pointing Alfred at the synced preferences folder..."
  defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "$DOTFILES_DIR/alfred"
  warning "Restart Alfred for the sync folder to take effect."
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  install_xcode
  install_homebrew
  run_brew_bundle
fi
