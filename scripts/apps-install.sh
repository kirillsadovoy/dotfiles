#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

install_xcode() {
  info "Installing Apple's CLI tools (prerequisites for Git and Homebrew)..."
  if xcode-select -p >/dev/null; then
    warning "xcode is already installed"
  else
    xcode-select --install
    sudo xcodebuild -license accept
  fi
}

install_homebrew() {
  info "Installing Homebrew..."
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  if hash brew &>/dev/null; then
    warning "Homebrew already installed"
  else
    sudo --validate
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

run_brew_bundle() {
  brewfile="$SCRIPT_DIR/../Brewfile"
  if [ -f $brewfile ]; then
    # Run `brew bundle check`
    local check_output
    check_output=$(brew bundle check --file="$brewfile" 2>&1)

    # Check if "The Brewfile's dependencies are satisfied." is contained in the output
    if echo "$check_output" | grep -q "The Brewfile's dependencies are satisfied."; then
      warning "The Brewfile's dependencies are already satisfied."
    else
      info "Satisfying missing dependencies with 'brew bundle install'..."
      brew bundle install --file="$brewfile"
    fi
  else
    error "Brewfile not found"
    return 1
  fi
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  install_xcode
  install_homebrew
  run_brew_bundle
fi
