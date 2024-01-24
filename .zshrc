SHELL_SESSIONS_DISABLE=1
setopt SHARE_HISTORY

# initialize autocompletion
autoload -U compinit && compinit

setopt NO_BEEP

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
# autocompletion for partial words
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rmeclipse='find . \( -name ".classpath" -o -name ".project" -o -name ".settings" \) -exec rm -rf "{}" +'

eval "$(starship init zsh)"