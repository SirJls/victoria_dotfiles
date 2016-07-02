# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf
# ----------------------------------------------------

# Source xmodmap
# ----------------------------------------------------
if [ -f ~/dotfiles/xmodmaprc ]; then
    xmodmap ~/.xmodmaprc
fi

# Start keyring and export environment variables
# ----------------------------------------------------
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

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
pulseaudio --start

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
# /usr/bin/setroot --restore 2>/dev/null
feh --bg-scale /home/jls/pictures/wallpaper/determinate.jpg

# hide cursor
# ----------------------------------------------------
/usr/bin/unclutter -noevents -idle 3 &

# disable CapsLock & map to Escape
# ----------------------------------------------------
/usr/bin/setxkbmap -option caps:swapescape
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# run numlockx
# ----------------------------------------------------
/usr/bin/numlockx &

# Intellij fix for misbehaving java application for dwm
# ----------------------------------------------------
wmname LG3D

# Intellij needs a higher watch limit
# ----------------------------------------------------
sysctl fs.inotify.max_user_watches=524288
sysctl --system

# set cursor
# ----------------------------------------------------
/usr/bin/xsetroot -cursor_name left_ptr &

# clipboard synching
# ----------------------------------------------------
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# start dwm
# ----------------------------------------------------
exec $HOME/scripts/dwm-start
