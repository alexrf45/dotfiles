#zshrc config
# Author: Sean Fontaine
# Email: alex_r0land@pm.me

#history config
HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob

#turn off beep 
unsetopt beep
#vi key bindings
bindkey -v

#source aliases and env
source "$HOME/.zprofile"
source "$HOME/.zsh/aliases.zsh"

fpath=(/tmp/zsh-completions/src $fpath)

#displays saying in every new prompt
cowsay $(fortune)

#persistant ssh agent
eval $(ssh-agent) > /dev/null

ssh-add ~/.ssh/dev > /dev/null
ssh-add ~/.ssh/homelab > /dev/null
ssh-add ~/.ssh/homeadm > /dev/null

#history log function
    precmd() { eval 'if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history -f)" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log; fi' }

alias clear-history='cp $HOME/.history $HOME/dev-bckup/arch-history/.history_backup && echo "" > $HOME/.r0land_history'

alias hist-backup='cp -r ~/.logs/* ~/dev-bckup/arch-history/'

eval "$(starship init zsh)"

#miniplug zsh
source "$HOME/.zsh/miniplug.zsh"

# Define a plugin
miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'jameshgrn/zshnotes'
# Define a theme
#miniplug theme 'dracula/zsh'
# Source plugins
miniplug load

#bash-completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

#aws autocompletion
complete -C '/usr/local/bin/aws_completer' aws

declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"



