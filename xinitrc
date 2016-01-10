# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
# ----------------------------------------------------

# Source xmodmap
# ----------------------------------------------------

if [ -f ~/dotfiles/xmodmaprc ]; then
    xmodmap ~/.xmodmaprc
fi

# Start keyring nd export environment variables
# ----------------------------------------------------
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# external monitor
# ----------------------------------------------------
external=$(xrandr -q | awk '/HDMI1/ {print $2}')
if [ "$external" = connected ]; then
  xrandr --output eDP1 --mode 1600x900 --pos 0x0 --below HDMI1 \
  --output HDMI1 --mode 1680x1050 --pos 0x900
fi

# X settings
# ----------------------------------------------------
xrdb -merge .Xresources &&

# create global xdg variables
# ----------------------------------------------------
. ~/scripts/make-xdg

# run urxvt daemon client
# ----------------------------------------------------
urxvtd -q -f -o

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

# speed up key repeat
# ----------------------------------------------------
xset r rate 200 30

# set wallpaper
# ----------------------------------------------------
/usr/bin/setroot --restore 2>/dev/null

# hide cursor
# ----------------------------------------------------
/usr/bin/unclutter -noevents -idle 3 &

# disable CapsLock & map to Escape
# ----------------------------------------------------
/usr/bin/setxkbmap -option caps:swapescape

# run numlckx
# ----------------------------------------------------
/usr/bin/numlockx &

# set cursor
# ----------------------------------------------------
/usr/bin/xsetroot -cursor_name left_ptr &

# clipboard synching
# ----------------------------------------------------
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# start awesome
# ----------------------------------------------------
exec $HOME/scripts/dwm-start
