# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "mafredri/zsh-async"
plug "sindresorhus/pure"
plug "zsh-users/zsh-syntax-highlighting"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Vim keybindings
bindkey -v
# zsh for some reason don't propperly handle extended charcodes from ghostty
bindkey '^[[91;5u' vi-cmd-mode # Ctrl-[
