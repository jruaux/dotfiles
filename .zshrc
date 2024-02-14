SHELL_SESSIONS_DISABLE=1
setopt SHARE_HISTORY

# initialize autocompletion
autoload -U compinit && compinit

setopt NO_BEEP

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
function rmeclipse() {
    if [ -z "$1" ]; then
        echo "Usage: rmeclipse <directory>"
        return 1
    fi

    find "$1" \( -name ".classpath" -o -name ".project" -o -name ".settings" \) -exec rm -rf {} +
}

eval "$(starship init zsh)"
