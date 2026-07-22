# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export PURE_GIT_PULL=0

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "mafredri/zsh-async"
plug "sindresorhus/pure"
plug "zsh-users/zsh-syntax-highlighting"

# Neovim as default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Vim keybindings
bindkey -v
# zsh for some reason don't propperly handle extended charcodes from ghostty
bindkey '^[[91;5u' vi-cmd-mode # Ctrl-[

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# 1Password CLI
if command -v op >/dev/null 2>&1; then
  # Use the 1Password app as the SSH agent (enable in Settings > Developer > SSH Agent)
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  # Shell completion
  eval "$(op completion zsh)"
  compdef _op op
  # Shell plugins (gh, aws, ...) set up via `op plugin init <cli>`
  [ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"
fi
