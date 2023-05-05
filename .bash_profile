#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[ -n "${DISPLAY}" ] && exit 1

exec ~/scripts/desktop/start.bash
