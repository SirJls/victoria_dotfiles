
# file:     $HOME/.zsh/.zprofile
# author    jls - http://sjorssparreboom.nl
# ----------------------------------------------------

# export dirs to path
# ----------------------------------------------------
declare -U path
path=($HOME/scripts /usr/lib/surfraw $path)

# start keychain
# ----------------------------------------------------
if [[ -z $(pidof ssh-agent) && -z $(pidof gpg-agent) ]]; then
  eval $(/usr/bin/keychain --eval -Q -q --nogui --agents "ssh,gpg" id_rsa 534064D4)
fi

# startx if on tty1 and tmux on tty2
# ----------------------------------------------------
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx -- vt1 -keeptty &>/dev/null
  logout
elif [[ $(tty) = /dev/tty2 ]]; then
  tmux -f $HOME/.tmux/conf new -s secured
fi
