#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

set_osx_system_defaults() {
  info "Set OSX system defaults..."

  # Repeats the key as long as it is held down
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write -g InitialKeyRepeat -int 20
  defaults write -g KeyRepeat -int 5

  # Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Show full url in Safari
  defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool true

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Set column view for finder
  defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

  # Keep folders on top in finder
  defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true" && killall Finder

  # Show hidden files inside the finder
  defaults write com.apple.finder "AppleShowAllFiles" -bool true

  # Show all file extensions inside the Finder
  defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true

  # Show Status Bar
  defaults write com.apple.finder "ShowStatusBar" -bool true

  # Do not show warning when changing the file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
  defaults write com.apple.screencapture type -string "png"

  # Remove the default shadow from screenshots
  defaults write com.apple.screencapture "disable-shadow" -bool true

  # Spaces span all displays
  defaults write com.apple.spaces "spans-displays" -bool false

  # Do not rearrange spaces automatically
  defaults write com.apple.dock "mru-spaces" -bool false

  # Set Dock autohide and icons siae
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock largesize -float 128
  defaults write com.apple.dock "minimize-to-application" -bool true
  defaults write com.apple.dock tilesize -float 32
  defaults write com.apple.dock mineffect -string "scale"

  # Do not display recent apps in the Dock
  defaults write com.apple.dock "show-recents" -bool false

  # Notifications will not be displayed for apple music
  defaults write com.apple.Music "userWantsPlaybackNotifications" -bool false

  # Don't offer new disks for Time Machine backup
  defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool true
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  set_osx_system_defaults
fi
