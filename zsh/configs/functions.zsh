# -- Meta ---------------------------------------------------------------------
# -- File:   ${DOTFILES}/zsh/configs/functions
# -- Author: SirJls - http://sjorssparreboom.nl
# -- Credits: Jason W Ryan (file is heaviliy based on his functions.zsh)
# -----------------------------------------------------------------------------

# -- Helpers ------------------------------------------------------------------


extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *)           echo "\`$1': unrecognized file compression" ;;
    esac
  else
    echo "\`$1' is not a valid file"
  fi
}

zone() { TZ="$1"/"$2" date; }
zones() { ls /usr/share/zoneinfo/"$1" ;}

forecast() { curl -s wttr.in/rotterdam | head -n -2 ;}

zhist() { "history" 0 | grep -i "$1" ;}

shux() { TERM=xterm-256color; ssh "$1" -t LANG=en_GB.utf-8 tmux a -d ;}

pids() { ps aux | grep "$1" ;}

sprung() { curl -F "sprunge=<-" http://sprunge.us <"$1" ;}

aurup() { awk '{print $2}' </tmp/aurupdates* ;}

allaurpkgs() { pacman -Qqettm ; }

allpacpkgs() { pacman -Qqettn ; }

paclog() { tail -n"$1" /var/log/pacman.log ;}

px() { printf '%s\n' $(xsel -b); }

conv() { units "$1" "$2" | awk 'NR==1 {print $2}'; }

sx() { sxiv -trq "$@" 2>/dev/null ;}

cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

wmip() { printf "External IP: %s\n" $(curl -s  http://ifconfig.co/) ;}

wx() { [[ $# -eq 1 ]] && { sudo netctl stop-all && sudo netctl start "$1" ; } }

manp() { man -t "$@" | lpr -pPrinter; }

pbx() {
  curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' \
    -o /dev/stderr | xsel -l /dev/null -b
}

mux() {
  if [[ -z "$TMUX" ]]; then
    tmux attach -d
  else
    tmux -f ${DOTFILES}/tmux/tmux.conf new -s secured
  fi
}

nmount() {
  (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t
}

manpdf() {
  man -t "$@" | ps2pdf - /tmp/manpdf_$1.pdf && xdg-open /tmp/manpdf_$1.pdf
}

officepdf() {
  (( $# != 2 )) && exit 1
  unoconv -f pdf -o "${1}" "${2}"
}

bak() {
  if [[ ${1: -4} == ".bak" ]]; then
    cp -rf "$1" ${1%.bak}
  else
    cp -rf "$1" ${1}.bak
  fi
}

selfie() {
  mkdir -p "${HOME}/Pictures/Webcam" &>/dev/null
  selfie="${HOME}/Pictures/Webcam/$(date +%H:%M-%d%m%y).jpeg"
  fswebcam --resolution 640x480 --no-banner --jpeg 95 --skip 10 $selfie
}

function ranger() {
  if [ -z "$RANGER_LEVEL" ]; then
    local tempfile="$(mktemp -t tmp.XXXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      builtin cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
  else
    exit
  fi
}
