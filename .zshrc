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


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

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

source "$HOME/.miniplug/plugins/miniplug.zsh"

miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'zsh-users/zsh-completions'
miniplug theme 'dracula/zsh'
miniplug load

fpath=($HOME/.miniplug/plugins/zsh-users/zsh-completions/src $fpath)

source <(kubectl completion zsh)

. "$HOME/.cargo/env"

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. <(flux completion zsh)

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

source "/home/fr3d/.config/op/plugins.sh"

#zprof > /tmp/zprof.out
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
