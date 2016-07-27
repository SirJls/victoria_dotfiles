# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author jls - http://sjorssparreboom.nl
# vim:nu:ai:et:sw=4:ts=4:ft=xinitrc
# ----------------------------------------------------

# source Xresources
# ----------------------------------------------------
if [[ -f ~/.Xresources ]] && [[ -e /usr/bin/xrdb ]]; then 
    xrdb -merge $HOME/.Xresources
fi

# Start keyring and export environment variables
# ----------------------------------------------------
if [[ -e /usr/bin/gnome-keyring ]]; then 
    eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
    export SSH_AUTH_SOCK }
fi

# external monitor
# ----------------------------------------------------
external=$(xrandr -q | awk '/HDMI1/ {print $2}')
if [ "$external" = connected ]; then
    . ~/scripts/detect_monitor
fi

# create global xdg variables
# ----------------------------------------------------
. ~/scripts/make-xdg

# enable restart X
# ----------------------------------------------------
setxkbmap -option terminate:ctrl_alt_bk

# start xbindkeys
# ----------------------------------------------------
xbindkeys --file ~/dotfiles/xbindkeysrc

# start pulseaudio
# ----------------------------------------------------
#if [[ -e /usr/bin/pulseaudio ]]; then
#    /usr/bin/pulseaudio --start
#fi

# compose key
# ----------------------------------------------------
setxkbmap -option compose:ralt

# brightness
# ----------------------------------------------------
xbacklight -set 45% &

# turn of screensaver
# ----------------------------------------------------
xset s off -dpms

# let me print pdf files
# ----------------------------------------------------
lpadmin -p Canon-MP620-series -o pdftops-renderer-default=pdftops

# speed up key repeat
# ----------------------------------------------------
xset r rate 200 30

# set wallpaper
# ----------------------------------------------------
if [[ -e /usr/bin/feh ]]; then
    feh --bg-scale $HOME/pictures/wallpaper/determinate.jpg
fi

# hide cursor
# ----------------------------------------------------
if [[ -e /usr/bin/unclutter ]]; then
    /usr/bin/unclutter -noevents -idle 3 &
fi

# disable CapsLock & map to Escape
# ----------------------------------------------------
if [[ -e /usr/bin/xmodmap ]]; then
    /usr/bin/xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
fi

# run numlockx
# ----------------------------------------------------
if [[ -e /usr/bin/numlockx ]]; then 
    /usr/bin/numlockx &
fi

# Intellij fix for misbehaving java application for dwm
# ----------------------------------------------------
if [[ -e /usr/bin/wmname ]]; then
    wmname LG3D
fi

# Intellij needs a higher watch limit
# ----------------------------------------------------
sysctl fs.inotify.max_user_watches=524288
sysctl --system

# set cursor
# ----------------------------------------------------
if [[ -e /usr/bin/xsetroot ]]; then
    /usr/bin/xsetroot -cursor_name left_ptr &
fi

# clipboard synching
# ----------------------------------------------------
if [[ -e /usr/bin/autocutsel ]]; then
    /usr/bin/autocutsel -fork &
    /usr/bin/autocutsel -selection PRIMARY -fork &
fi

# spawn terminal
#----------------------------------------------------
if [[ -e /usr/bin/urxvtc ]]; then
     urxvtc &
fi

# dunst as a background process
# ----------------------------------------------------
if [[ -e /usr/bin/dunst ]]; then
     /usr/bin/dunst &
fi

# set wallpaper
# ----------------------------------------------------
feh --bg-scale $HOME/pictures/wallpapers/arch-paper-wallpaper.jpg

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
