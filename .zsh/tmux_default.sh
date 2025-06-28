# #!/bin/bash
#
# tmux_default() {
#   if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmuxp load ~/.config/tmuxp/debian-desktop.yaml
#   fi
# }
#
# tmux_default
