# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author jls - http://sjorssparreboom.nl
# ----------------------------------------------------

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# external monitor
# ----------------------------------------------------
external=$(xrandr -q | awk '/HDMI1/ {print $2}')
if [ "$external" = connected ]; then
    . ~/scripts/detect-monitor
fi

# source Xresources
# ----------------------------------------------------
if [[ -f ~/.Xresources ]] && ( hash xrdb ); then 
    xrdb -merge $HOME/.Xresources
fi

# compose key and enable restart x
# ----------------------------------------------------
if ( hash setxkbmap ); then
	setxkbmap -option compose:ralt &&
	setxkbmap -option terminate:ctrl_alt_bk
fi


# start xbindkeys
# ----------------------------------------------------
if ( hash xbindkeys ); then
	xbindkeys --file ~/dotfiles/xbindkeysrc
fi

# brightness
# ----------------------------------------------------
if ( hash xbacklight ); then
	xbacklight -set 45% &
fi

# set wallpaper
# ----------------------------------------------------
if ( hash feh ); then
	feh --bg-scale $HOME/pictures/wallpapers/arch-paper-wallpaper.jpg
fi

# set cursor
# ----------------------------------------------------
if ( hash xsetroot ); then
    xsetroot -cursor_name left_ptr &
fi

# hide cursor
# ----------------------------------------------------
if ( hash /usr/bin/unclutter ); then
    unclutter -noevents -idle 3 &
fi

# clipboard synching
# ----------------------------------------------------
if  ( hash autocutsel ); then
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &
fi

# turn of screensaver
# ----------------------------------------------------
xset s off -dpms
xset s noblank

# # let me print pdf files
# # ----------------------------------------------------
# lpadmin -p Canon-MP620-series -o pdftops-renderer-default=pdftops

# speed up key repeat
# ----------------------------------------------------
if ( hash xset); then
	xset r rate 200 30
fi

# disable CapsLock & map to Escape
# ----------------------------------------------------
if ( hash xmodmap ); then
    xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
fi

# Intellij fix for misbehaving java application for dwm
# ----------------------------------------------------
if ( hash wmname ); then
    wmname LG3D
fi

# Intellij needs a higher watch limit
# ----------------------------------------------------
if ( hash sysctl ); then
	sysctl fs.inotify.max_user_watches=524288
	sysctl --system
fi

# spawn terminal
#----------------------------------------------------
# if ( hash urxvtc ); then
#      urxvtc &
# fi

# dunst as a background process
# ----------------------------------------------------
if ( hash dunst ); then
     dunst &
fi

# export dbus session address so it can be used by cron
# ----------------------------------------------------
if [[ -f ~/scripts/export-x-info ]]; then
    . ~/scripts/export-x-info
fi

# external usb sound card fix
# ----------------------------------------------------
if [[ -f ~/scripts/usb-audio-fix ]]; then
    . ~/scripts/usb-audio-fix
fi

# start dwm
# ----------------------------------------------------
exec $HOME/scripts/dwm-start
