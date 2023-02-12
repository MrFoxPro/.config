#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
if [ -z "${DISPLAY}" ]; then
	if [ "${XDG_VTNR}" -eq 1 ]; then
		exec startx ~/.xinitrc
	elif [ "${XDG_VTNR}" -eq 2 ]; then
		exec sway --unsupported-gpu
	elif [ "${XDG_VTNR}" -eq 3 ]; then
		exec startx ~/.xinit2rc -- :3
	fi
fi
