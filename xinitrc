# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
# ----------------------------------------------------

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
# exec awesome
exec $HOME/scripts/dwm-start
