 #zmodload zsh/zprof

setopt AUTO_CD
setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt NOMATCH
setopt MENU_COMPLETE
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS # Don't save duplicate lines
setopt HIST_VERIFY
setopt SHARE_HISTORY      # Share history between sessions
setopt PROMPT_SUBST
unsetopt beep

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffffff,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

source "$HOME/.zprofile"

for file in $HOME/.zsh/*; do
    source "$file"
done

autoload -Uz colors; colors
autoload -Uz compinit && compinit

source "$HOME/.miniplug/plugins/miniplug.zsh"

miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'zsh-users/zsh-completions'

miniplug load

fpath=($HOME/.miniplug/plugins/zsh-users/zsh-completions/src $fpath)

source <(kubectl completion zsh)

compdef k='kubectl'

. "$HOME/.cargo/env"

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. <(flux completion zsh)

eval "$(zoxide init zsh)"

eval "$(starship init zsh)"

#zprof > /tmp/zprof.out
