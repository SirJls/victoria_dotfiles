# ----------------------------------------------------
# file:     $HOME/dotfiles/zshenv
# author    jls - http://sjorssparreboom.nl
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
export PAGER="/usr/bin/less"
export SDCV_PAGER="/usr/bin/less"
export SYSTEMD_PAGER="less -j4aR"
export PASS_DIR="$HOME/.password-store"
export GOPATH="$HOME/workspace/go" # for bin see zprofile
export NOTES_DIR="$HOME/.notes"

# Environment variables used by soundctl
# ----------------------------------------------------
export DEFAULT_PROFILE="output:analog-stereo+input:analog-stereo"
export DEFAULT_SND_CARD="alsa_card.pci-0000_00_1b.0"
export DEFAULT_SINK="alsa_output.pci-0000_00_1b.0.analog-stereo"

export HDMI_PROFILE="output:hdmi-stereo-extra1"
export HDMI_SND_CARD="alsa_card.pci-0000_00_03.0"
export HDMI_SINK="alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1"

export EXTERNAL_PROFILE_00="output:analog-stereo+input:analog-mono"
export EXTERNAL_SND_CARD_00="alsa_card.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00"
export EXTERNAL_SINK_00="alsa_output.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.analog-stereo"

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
