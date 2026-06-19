setopt SHARE_HISTORY      # Share history between sessions
setopt HIST_IGNORE_DUPS # Don't save duplicate lines
setopt EXTENDED_HISTORY
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto      # update automatically without asking

zstyle ':omz:update' frequency 7

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(
  colorize
  git
  tailscale
  themes
  web-search
)

source $ZSH/oh-my-zsh.sh

source "$HOME/.zprofile"

for file in $HOME/.zsh/*; do
    source "$file"
done

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

. "$HOME/.cargo/env"

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"

source "/home/fr3d/.config/op/plugins.sh"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH="/home/fr3d/.devcontainers/bin:$PATH"

