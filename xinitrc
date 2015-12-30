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

# enable restart X
# ----------------------------------------------------
setxkbmap -option terminate:ctrl_alt_bk

# start xbindkeys
# ----------------------------------------------------
xbindkeys --file ~/dotfiles/xbindkeysrc

# start pulseaudio
# ----------------------------------------------------
pulseaudio --start

# disable CapsLock & map to Escape
# ----------------------------------------------------
/usr/bin/setxkbmap -option caps:swapescape

# compose key
# ----------------------------------------------------
setxkbmap -option compose:ral

# brightness
# ----------------------------------------------------
xbacklight -set 45% &

# numlock
# ----------------------------------------------------
/usr/bin/numlockx &

# turn of screensaver
# ----------------------------------------------------
xset s off -dpms

# hide cursor
# ----------------------------------------------------
/usr/bin/unclutter -noevents -idle 3 &

# speed up key repeat
# ----------------------------------------------------
xset r rate 200 30

# set cursor
# ----------------------------------------------------
/usr/bin/xsetroot -cursor_name left_ptr &

# clipboard synching
# ----------------------------------------------------
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

# start awesome
# ----------------------------------------------------
exec awesome
