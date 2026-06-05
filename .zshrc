#zmodload zsh/zprof

setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY
setopt NOMATCH
setopt MENU_COMPLETE
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_DUPS # Don't save duplicate lines
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY      # Share history between sessions
setopt PROMPT_SUBST
unsetopt beep
setopt HIST_IGNORE_SPACE



ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffffff,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="10"
ZSH_AUTOSUGGEST_USE_ASYNC=1

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

autoload -Uz add-zsh-hook


source "$HOME/.zprofile"

for file in $HOME/.zsh/*; do
    source "$file"
done

add-zsh-hook chpwd auto_venv

autoload -Uz colors; colors
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Configure Git tracking details
zstyle ':vcs_info:git:*' formats '%F{13} %b%f '
PROMPT=$'%{\e[38;5;240m%}%~%{\e[38;5;255m%} // %{\e[38;5;120m%}$(git branch 2>/dev/null | grep \'^*\' | colrm 1 2 | xargs -I{} echo " git:({})") %{\e[38;5;255m%}$ %{\e[0m%}'

export PS1
source <(kubectl completion zsh)
source <(scrt completion zsh)

. "$HOME/.cargo/env"

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

source "/home/fr3d/.config/op/plugins.sh"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH="/home/fr3d/.devcontainers/bin:$PATH"

#zprof > /tmp/zprof.out
