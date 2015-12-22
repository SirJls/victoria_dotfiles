# ----------------------------------------------------
# file: $HOME/dotfiles/xinitrc
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
# ----------------------------------------------------

# Trun of screensaves
# ------------------------------------
xset s off

# Speed up key repeat
# ------------------------------------
xset r rate 200 30

# X settings
# ------------------------------------
xrdb -merge .Xresources && 

# Set background
# ------------------------------------
# feh --bg-tile ~/documents/pictures/wallpapers/vintage.jpg

# Enable restart X
# ------------------------------------
setxkbmap -option terminate:ctrl_alt_bk

# Start xbindkeys
# ------------------------------------
xbindkeys --file ~/dotfiles/xbindkeysrc

# Start pulseaudio
# -----------------------------------
pulseaudio --start

# Activate modmap
# -----------------------------------
if [ -f ~/dotfiles/xmodmaprc ]; then
    xmodmap ~/dotfiles/xmodmaprc
fi

# Activate xcompmgr
# -----------------------------------
# xcompmgr -c &

# Start awesome
# -----------------------------------
exec awesome
