# ----------------------------------------------------
# file:     ${DOTFILES}/zsh/functions.zsh
# author:   sjors - http://sjorssparreboom.nl
# ----------------------------------------------------
# Heavily based on the work of Json Ryan
# ----------------------------------------------------

# Extract Files
# ----------------------------------------------------
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

# check history
# ----------------------------------------------------
zhist() { "history" 0 | grep -i "$1" ;}

# ssh and run application
# ----------------------------------------------------
shux() { TERM=xterm-256color; ssh "$1" -t LANG=en_GB.utf-8 tmux a -d ;}

# grab pid
# ----------------------------------------------------
pids() { ps aux | grep "$1" ;}

# paste to sprunge
# ----------------------------------------------------
sprung() { curl -F "sprunge=<-" http://sprunge.us <"$1" ;}

# grab list of updates
# ----------------------------------------------------
aurup() { awk '{print $2}' </tmp/aurupdates* ;}

# all aur packages
# ----------------------------------------------------
allaurpkgs() { pacman -Qqettm ; }

# all packman packages
# ----------------------------------------------------
allpacpkgs() { pacman -Qqettn ; }

# check pacman's log
# ----------------------------------------------------
paclog() { tail -n"$1" /var/log/pacman.log ;}

# paste from clipboard
# ----------------------------------------------------
px() { printf '%s\n' $(xsel -b); }

# pastebin
# ----------------------------------------------------
pbx() {
curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' \
    -o /dev/stderr | xsel -l /dev/null -b
}

# conversion tool
# ----------------------------------------------------
contool() { units "$1" "$2" | awk 'NR==1 {print $2}'; }

# scan dir for thumbs
# ----------------------------------------------------
sx() { sxiv -trq "$@" 2>/dev/null ;}

# Follow copied and moved files to destination directory
# ----------------------------------------------------
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

# External IP
# ----------------------------------------------------
wmip() { printf "External IP: %s\n" $(curl -s  http://ifconfig.co/) ;}

# Netctl profiles
# ----------------------------------------------------
wx() { [[ $# -eq 1 ]] && { sudo netctl stop-all && sudo netctl start "$1" ; } }

# attach tmux to existing session
# ----------------------------------------------------
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux -f $HOME/.tmux/conf new -s secured ;} }

# International timezone
# ----------------------------------------------------
zone() { TZ="$1"/"$2" date; }
zones() { ls /usr/share/zoneinfo/"$1" ;}

# weather
# ----------------------------------------------------
forecast() { curl -s wttr.in/rotterdam | head -n -2 ;}

# Nice mount output
# ----------------------------------------------------
nmount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

# Print man pages
# ----------------------------------------------------
manp() { man -t "$@" | lpr -pPrinter; }

# Create pdf of man page - requires ghostscript and mimeinfo
# ----------------------------------------------------
manpdf() { man -t "$@" | ps2pdf - /tmp/manpdf_$1.pdf && xdg-open /tmp/manpdf_$1.pdf ;}

# Convert office documents to pdf
# ----------------------------------------------------
officepdf() { (( $# != 2 )) && printf "%s\n" "I accept input and produce output!" || unoconv -f pdf -o "$2" "$1" }

# Create an iso
# ----------------------------------------------------
isocreate() {
    if (( $# != 2 )) then;
        printf "%s\n" "Specify a file{name/path} and a source."
        return 1
    else
        mkisofs -o "$1" "$2"
        printf "%s\n" "Done... ISO ${1} created!"
        return 0
    fi
}

# check iso
# ----------------------------------------------------
isoinspect() { [[ ! -e ~/.mtoolsrc ]] && echo mtools_skip_check=1 >> ~/.mtoolsrc; mdir -i "$1" ; }

# Create a zero files
# ----------------------------------------------------
zerofile() {
    if (( $# != 3 )) then;
        printf "%s\n" "Specify a filename, block size with extension and a count!"
        return 1
    else
        dd if=/dev/zero of="$1" bs="$2" count="$3"
        printf "%s\n" "Don't forget to mount a filesystem, goodbye!"
        return 0
    fi
}

# check if two strings are the same
# ----------------------------------------------------
equal() { [[ "$1" == "$2" ]] && echo "True" || echo "False"; }

# rename usb
# ----------------------------------------------------
usbrename() { sudo dosfslabel "$1" "$2" ; }

# Create .bak for file
# ----------------------------------------------------
bak() { [[ ${1: -4} == ".bak" ]] && cp -rf "$1" ${1%.bak} || cp -rf "$1" ${1}.bak }

# snap from webcam
# ----------------------------------------------------
selfie() { fswebcam --resolution 640x480 --no-banner --jpeg 95 --skip 10 $HOME/pictures/webcam/$(date +%H:%M-%d%m%y).jpeg ; }

# open preconfigured project setups
# ----------------------------------------------------
po() {
    (( $# != 1 )) && printf "%s\n" "I need a tmuxinator project to start!" && exit 1
    tmuxinator start "$1"
}

# sent mail
# ----------------------------------------------------
sm() { (( $# == 4)) && mutt -s "$1" -a "$2" -- "$3" <<< "$4" || mutt -s "$1" -- "$2" <<< "$3" ; }

# simple notes
# ----------------------------------------------------
n() {
  local files
  files=(${@/#/$HOME/.notes/})
  ${EDITOR:-vi} $files
}

# list notes
# ----------------------------------------------------
nls() {
  tree -CR --dirsfirst --noreport $HOME/.notes | awk '{
    if (NF==1) print $1;
    else if (NF==2) print $2;
    else if (NF==3) printf "  %s\n", $3
  }'
}

# ranger
# ----------------------------------------------------
function ranger() {
  if [ -z "$RANGER_LEVEL" ]; then
    local tempfile="$(mktemp -t tmp.XXXXXXX)"
    # for manual install
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    # for package install
    # /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        builtin cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
  else
    exit
  fi
}
