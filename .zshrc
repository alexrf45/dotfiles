setopt extended_glob null_glob

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions
setopt PROMPT_SUBST
unsetopt beep

#history config
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HIST_STAMPS="mm/dd/yyyy"

#history log function
    precmd() { eval 'if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history -f)" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log; fi' }

alias clear-history='cp $HOME/.zsh_history $HOME/projects/configs/.history_backup && truncate -s 0 $HOME/.zsh_history'

#source aliases and env
source "$HOME/.zprofile"

for file in $HOME/.zsh/*; do
    source "$file"
done


fpath=(/tmp/zsh-completions/src $fpath)

source "$HOME/.miniplug/plugins/miniplug.zsh"

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

source <(kubectl completion zsh)

# #ssh agent
# eval $(ssh-agent -s) &> /dev/null
#
# ssh-add ~/.ssh/fr3d >/dev/null 2>&1
# ssh-add ~/.ssh/lab >/dev/null 2>&1
# ssh-add ~/.ssh/home >/dev/null 2>&1
# ssh-add ~/.ssh/vps >/dev/null 2>&1


export MINIPLUG_HOME="$HOME/.miniplug/plugins"

miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'zsh-users/zsh-completions'
miniplug load

. "$HOME/.cargo/env"

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. <(flux completion zsh)

#eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(zoxide init zsh)"
