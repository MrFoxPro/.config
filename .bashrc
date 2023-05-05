# If not running interactively, don't do anything
[[ $- != *i* ]] && return

blue="\[$(tput setaf 4)\]"
reset="\[$(tput sgr0)\]"
hn=$([ "$HOSTNAME" != "foxpro-arch" ] && echo "@\n" || echo "")
PS1="\u${hn}:$blue\w$reset$ "

alias ls='ls --color=auto'
alias ctl='systemctl'
alias ctlu='systemctl --user'
alias ip-public='curl -s ipinfo.io/ip'
# xdg user dirs
set -a
source ~/.config/user-dirs.dirs
set +a


# nano as default editor
export VISUAL=helix
export EDITOR=helix
export GIT_EDITOR=helix

# tabtab source for packages
# [ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true

# HSTR configuration - add this to ~/.bashrc
export HSTR_CONFIG=raw-history-view,hicolor       # get more colors
# shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignoreboth:erasedups   # leading space hides commands from history
export HISTFILESIZE=
export HISTSIZE=
export HISTFILE=~/.bash_history
# ensure synchronization between bash memory and history file
# export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
# if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
# if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

# source <(carapace _carapace)

# pnpm
export PNPM_HOME="/home/foxpro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# export PATH="/home/foxpro/.cargo/bin:$PATH"
