#zstyle :omz:plugins:ssh-agent agent-forwarding yes
#zstyle :omz:plugins:ssh-agent identities ~/.ssh/dev
#zstyle :omz:plugins:ssh-agent quiet yes

HISTFILE=~/.history
HISTSIZE=5000
SAVEHIST=5000
setopt autocd extendedglob
unsetopt beep
bindkey -v

source "$HOME/.zprofile"
source "$HOME/.zsh/aliases.zsh"

fpath=(/tmp/zsh-completions/src $fpath)

cowsay $(fortune)

eval $(ssh-agent) > /dev/null

ssh-add ~/.ssh/dev > /dev/null

#miniplug zsh
source "$HOME/.zsh/miniplug.zsh"

# Define a plugin
miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-autosuggestions'
miniplug plugin 'jameshgrn/zshnotes'
# Define a theme
miniplug theme 'dracula/zsh'
# Source plugins
miniplug load
