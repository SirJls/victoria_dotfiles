# ----------------------------------------------------
# file:     $HOME/dotfiles/zshenv
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=zsh:
# ----------------------------------------------------

# Point Zsh at the right dotfiles
# ----------------------------------------------------
ZDOTDIR="${ZDOTDIR:-$HOME/.zsh}"

# Setup environment
# ----------------------------------------------------
export LC_ALL=
export LC_COLLATE="C"
export LC_CTYPE=$LANG
export LESS='-iMRj.5'
export PERL_SIGNALS="unsafe"
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/vimb"
export FT2_SUBPIXEL_HINTING="1"
export QUOTING_STYLE="literal"
export JavaScriptCoreUseJIT="0"
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
# export TERM="xterm-256color"
export GPG_TTY=$(tty)
export GPGKEY="534064D4"
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
export PAGER="/usr/bin/less"
export SDCV_PAGER="/usr/bin/less"
export SYSTEMD_PAGER="less -j4aR"
export PASS_DIR="$HOME/.password-store"

# Golang specifs
# ----------------------------------------------------
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"


# To stop ranger from loading both the default and my custom rc.conf
# ----------------------------------------------------
export RANGER_LOAD_DEFAULT_RC=false

# setup default dirs
# ----------------------------------------------------
[[ $XDG_CACHE_HOME ]] || export XDG_CACHE_HOME="$HOME/.cache"
[[ $XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ $XDG_DATA_HOME ]] || export XDG_DATA_HOME="$HOME/.local/share"

# Man page colours
# ----------------------------------------------------
# colored less
export LESS_TERMCAP_mb=$(tput bold)                # begin blinking
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)  # begin bold (blue)
export LESS_TERMCAP_me=$(tput sgr0)                # end mode
export LESS_TERMCAP_se=$(tput sgr0)                # end standout-mode
export LESS_TERMCAP_so=$(tput setaf 3; tput rev)   # begin standout-mode (yellow)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)     # end underline
export LESS_TERMCAP_us=$(tput smul; tput setaf 2)  # begin underline (green)

# start keychain
# ----------------------------------------------------
if [[ -z $(pidof ssh-agent) && -z $(pidof gpg-agent) ]]; then
  eval $(/usr/bin/keychain --eval -Q -q --nogui --agents "ssh,gpg" id_rsa 534064D4)
  [[ -z $HOSTNAME ]] && HOSTNAME=$(uname -n)
  [[ -f $HOME/.keychain/${HOSTNAME}-sh ]] && source $HOME/.keychain/${HOSTNAME}-sh
  [[ -f $HOME/.keychain/${HOSTNAME}-sh-gpg ]] && source $HOME/.keychain/${HOSTNAME}-sh-gpg
fi
