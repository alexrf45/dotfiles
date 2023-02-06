export MINIPLUG_HOME="$HOME/.zsh/plugins"


if [[ -z $TMUX ]]; then
  PATH="$PATH:/home/r0land/.local/bin:/home/r0land/go/bin:/usr/local/go/bin"
fi

export EDITOR=nvim
 
#aws-cli ENV
export AWS_REGION=us-east-1
export AWS_VAULT_BACKEND=pass
export AWS_PAGER=
export AWS_CLI_AUTO_PROMPT=on-partial

export NVM_DIR="$HOME/.config/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
