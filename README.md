# dotfiles

macOS setup: stow-managed configs, a Brewfile, and install scripts.

- `.config/` — nvim, tmux, ghostty, karabiner (symlinked into `~/.config` via stow)
- `.zshrc`, `.gitconfig` — symlinked into `~` via stow
- `alfred/` — Alfred preferences (used as Alfred's sync folder, not stowed)
- `Brewfile` — CLI tools, casks, and Mac App Store apps
- `scripts/` — the installer

## Fresh machine bootstrap

1. Sign in to **iCloud and the App Store** (needed for `mas` to install Xcode).
2. Install Apple's CLI tools (gives you `git`):

   ```sh
   xcode-select --install
   ```

3. Clone over HTTPS — SSH keys live in 1Password, which isn't installed yet:

   ```sh
   mkdir -p ~/Code
   git clone https://github.com/kirillsadovoy/dotfiles.git ~/Code/dotfiles
   ```

4. Run the installer and answer the prompts (each step is optional and idempotent):

   ```sh
   ~/Code/dotfiles/scripts/install.sh
   ```

   It installs Homebrew, runs `brew bundle`, symlinks the dotfiles with stow
   (pre-existing `~/.zshrc` / `~/.gitconfig` are backed up as `*.pre-dotfiles`),
   installs zap (zsh plugin manager) and Node LTS via nvm, applies macOS
   defaults, and points Alfred at `alfred/` as its sync folder.

## Manual steps after install

- **1Password**: sign in, then enable *Settings → Developer → SSH Agent*.
  Git auth and commit signing rely on it.
- Switch this repo's remote back to SSH:

  ```sh
  git -C ~/Code/dotfiles remote set-url origin git@github.com:kirillsadovoy/dotfiles.git
  ```

- **Alfred**: activate the license and grant accessibility permissions. Point it
  at the synced config **via Alfred's GUI** — *Settings → Advanced → Syncing →
  "Set preferences folder…"* → choose `~/Code/dotfiles/alfred`, then accept "use
  existing settings". This is what actually loads the workflows; the installer's
  `defaults write syncfolder` only sticks on Alfred's very first launch — an
  already-initialized Alfred resets it to empty on start. Set the launcher hotkey to **Option+Space**
  under *Settings → General → Alfred Hotkey* (this hotkey lives in Alfred's local
  process, not the synced folder, so it can't be scripted). The OSX-defaults step
  frees up Cmd+Space for input-source switching, so Alfred must move off it.
- **tmux**: start it and press `prefix + I` to install plugins via tpm.
- **Karabiner / Ghostty**: launch once and grant the requested permissions.
- **Keyboard layouts & Cmd+Space** (must be done in the GUI — writing these via
  `defaults` is unreliable on current macOS: layouts don't survive logout and the
  Spotlight hotkey isn't released live). In *System Settings → Keyboard*:
  1. *Text Input → Input Sources → Edit… → +* — add **Russian** (U.S. is default).
  2. *Keyboard Shortcuts… → Spotlight* — uncheck **Show Spotlight search** to free Cmd+Space.
  3. *Keyboard Shortcuts… → Input Sources* — set **Select the previous input source** to **Cmd+Space**.
  The `defaults` commands in `set-osx-defaults.sh` seed these values as best-effort,
  but the GUI pass above is what makes them stick.
- **Caps Lock → Control (system level)**: Karabiner already remaps this, but only
  once it's running (after login). The installer also installs a LaunchDaemon
  (`macos/com.local.KeyRemapping.plist` → `/Library/LaunchDaemons/`) that applies
  the remap via `hidutil` at boot, so Caps Lock behaves at the login window too.
  To (re)install manually:

  ```sh
  sudo cp ~/Code/dotfiles/macos/com.local.KeyRemapping.plist /Library/LaunchDaemons/
  sudo chown root:wheel /Library/LaunchDaemons/com.local.KeyRemapping.plist
  sudo launchctl bootstrap system /Library/LaunchDaemons/com.local.KeyRemapping.plist
  ```

  Remove with `sudo launchctl bootout system /Library/LaunchDaemons/com.local.KeyRemapping.plist && sudo rm /Library/LaunchDaemons/com.local.KeyRemapping.plist`.
- Log out and back in for trackpad and key-repeat settings to fully apply.
