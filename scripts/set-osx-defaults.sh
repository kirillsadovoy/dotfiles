#!/bin/bash

set -euo pipefail

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. $SCRIPT_DIR/utils.sh

DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Install a LaunchDaemon that maps Caps Lock -> Left Control at boot (via hidutil),
# so the remap is active at the login window and before Karabiner starts. Karabiner
# handles Caps->Ctrl once it's running; this only covers the pre-Karabiner window.
install_caps_to_control_daemon() {
  info "Installing Caps Lock -> Control LaunchDaemon (sudo)..."
  local src="$DOTFILES_DIR/macos/com.local.KeyRemapping.plist"
  local dst="/Library/LaunchDaemons/com.local.KeyRemapping.plist"
  sudo cp "$src" "$dst"
  sudo chown root:wheel "$dst"
  sudo chmod 644 "$dst"
  # Reload so it takes effect now (and applies at every subsequent boot)
  sudo launchctl bootout system "$dst" 2>/dev/null || true
  sudo launchctl bootstrap system "$dst" || warning "launchctl bootstrap failed — check '$dst'."
}

set_osx_system_defaults() {
  info "Set OSX system defaults..."

  # Repeats the key as long as it is held down
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write -g InitialKeyRepeat -int 20
  defaults write -g KeyRepeat -int 5

  # Keyboard input sources: U.S. and Russian layouts (plus the Character Viewer).
  # Written as the whole array (not -array-add) so re-running stays idempotent.
  # BEST-EFFORT ONLY: on current macOS this does NOT survive logout (the Text
  # Input registry re-derives its own list). Add Russian via the GUI to make it
  # stick — see the "Keyboard layouts & Cmd+Space" step in the README.
  defaults write com.apple.HIToolbox AppleEnabledInputSources -array \
    '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 0; "KeyboardLayout Name" = "U.S."; }' \
    '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 19456; "KeyboardLayout Name" = "Russian"; }' \
    '{ "Bundle ID" = "com.apple.CharacterPaletteIM"; InputSourceKind = "Non Keyboard Input Method"; }'

  # Free up Cmd+Space and bind it to input-source switching.
  # NOTE: set Alfred's launcher hotkey to Option+Space first (GUI step, see README),
  # otherwise Cmd+Space is contested. Symbolic-hotkey params are (ASCII, keycode, modifier);
  # Space = 32/49, Cmd = 1048576, Cmd+Option = 1572864.
  # BEST-EFFORT: values persist, but the live Spotlight/Text-Input daemons often
  # don't honor them until toggled once in the GUI — see the README step.
  # Disable Spotlight search (Cmd+Space) and Finder search (Cmd+Option+Space)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
    '{ enabled = 0; value = { parameters = ( 32, 49, 1048576 ); type = standard; }; }'
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 \
    '{ enabled = 0; value = { parameters = ( 32, 49, 1572864 ); type = standard; }; }'
  # Bind "Select the previous input source" to Cmd+Space (toggles U.S. <-> Russian)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 \
    '{ enabled = 1; value = { parameters = ( 32, 49, 1048576 ); type = standard; }; }'

  # Avoid creating .DS_Store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # Show full url in Safari
  defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool true

  # Show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Set column view for finder
  defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

  # Keep folders on top in finder
  defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

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

  # Trackpad: tap to click
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  # Trackpad: secondary (right) click in the bottom-right corner.
  # Mirrors the GUI "Click in bottom right corner" option, which turns off
  # two-finger right-click (TrackpadRightClick), so we disable that too.
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false

  # Disable the Spotlight metadata index on all volumes (needs sudo).
  # WARNING: this also disables Alfred's app/file search, which relies on the
  # same index. Re-enable with: sudo mdutil -a -i on
  info "Disabling Spotlight indexing (sudo)..."
  sudo mdutil -a -i off || warning "mdutil failed — run 'sudo mdutil -a -i off' manually."

  # Restart affected apps so the settings take effect
  killall Finder Dock SystemUIServer &>/dev/null || true
  warning "Some settings (trackpad, key repeat) only apply after logging out and back in."

  # Open the Keyboard pane for the manual GUI steps that can't be scripted
  # reliably (free Cmd+Space from Spotlight, bind it to input-source switching,
  # add the Russian layout). See the README for the exact clicks.
  warning "Opening Keyboard settings — finish the manual steps: Keyboard Shortcuts -> Spotlight (uncheck), Input Sources -> Select previous input source = Cmd+Space, and add the Russian layout."
  open "x-apple.systempreferences:com.apple.Keyboard-Settings.extension" &>/dev/null || true
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
  set_osx_system_defaults
fi
