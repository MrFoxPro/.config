#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

blue="\[$(tput setaf 4)\]"
reset="\[$(tput sgr0)\]"
hn=$([ "$HOSTNAME" != "foxpro-arch" ] && echo "@\n" || echo "")
PS1="\u${hn}:$blue\w$reset$ "

alias ls='ls --color=auto'
# xdg user dirs
set -a
source ~/.config/user-dirs.dirs
set +a

# pnpm
export PNPM_HOME="/home/foxpro/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
export PATH="/home/foxpro/.local/bin:$PATH"

# nano as default editor
export VISUAL=hx
export EDITOR=hx
export GIT_EDITOR=hx

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=raw-history-view,hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=erasedups:ignorespace   # leading space hides commands from history
# export HISTTIMEFORMAT="[%F %T] "
export HISTFILESIZE=20000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

