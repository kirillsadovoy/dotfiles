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

- **Alfred**: activate the license, restart Alfred so the sync folder applies,
  and grant accessibility permissions.
- **tmux**: start it and press `prefix + I` to install plugins via tpm.
- **Karabiner / Ghostty**: launch once and grant the requested permissions.
- Log out and back in for trackpad and key-repeat settings to fully apply.
