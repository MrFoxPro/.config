__dirname=$(dirname "$0")
cmdline="$(cat /proc/cmdline)"
regex=".*preset\=(.+).*"
if [[ $cmdline =~ $regex ]]; then
	x_preset="${BASH_REMATCH[1]}"
	echo "Loading preset $x_preset"
else
	echo "No preset specified"
	exit 1
fi

[ "${XDG_VTNR}" -eq 1 ] && target_bin="startxfce4"
[ "${XDG_VTNR}" -eq 2 ] && target_bin="i3"
[ "${XDG_VTNR}" -eq 3 ] && target_bin="bspwm"
if [[ -n "$target_bin" ]]; then
	echo "Prepare X11 configuration"
	config="$(cat $__dirname/$x_preset.conf)"
	if [ -n "$config" ]; then
		config_filename="20-dynamic.conf"
		echo "$config" >"/tmp/$config_filename"
		sudo rm -f /usr/share/X11/xorg.conf.d/$config_filename
		sudo ln -sf /tmp/$config_filename /usr/share/X11/xorg.conf.d/$config_filename
	fi
	exec startx ~/.xinitrc $target_bin -- :$XDG_VTNR
fi

echo "Prepare Wayland configuration"
export XDG_SESSION_TYPE=wayland
export LIBSEAT_BACKEND=logind

export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

# if nvidia available, use it first
# export WLR_DRM_DEVICES=/dev/dri/renderD128:/dev/dri/card0
# export WLR_DRM_DEVICES=/dev/dri/card1
# export WLR_RENDERER=vulkan

# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# export __GL_GSYNC_ALLOWED=0
# export __GL_VRR_ALLOWED=0

# https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/master/docs/env_vars.md
# export WLR_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0
# export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# export QT_QPA_PLATFORM=wayland-egl

[ "${XDG_VTNR}" -eq 4 ] && exec sway --unsupported-gpu
[ "${XDG_VTNR}" -eq 5 ] && exec river
[ "${XDG_VTNR}" -eq 6 ] && exec zellij
