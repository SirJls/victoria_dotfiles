# ------------------------------------
# file: $HOME/.zsh/.zshrc
# ------------------------------------

# Autoload & colours
#-------------------------------------
autoload -U colors && colors

# start archey on creation
#-------------------------------------
# archey

# create global xdg variables
#-------------------------------------
. ~/scripts/make-xdg.sh

# Autostartx
#-------------------------------------
[[ $(tty) = "/dev/tty1" ]] && exec startx

# Prompts
#-------------------------------------
PROMPT="┌─[%{$fg[magenta]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
└─╼ "

# Colour core
# -----------------------------------
export GREP_COLOR="1;31"

# Colors for ls
# -----------------------------------
if [[ -f ~/dotfiles/dir_colors ]]; then
    eval $(dircolors -b ~/.dir_colors)
fi

# The 'ls' family
#-------------------------------------
alias ll="ls -l --group-directories-first"
alias ls="ls -h --color"    # add colors for filetype recognition
alias la="ls -A"            # show hidden files
alias lx="ls -xb"           # sort by extension
alias lk="ls -lSr"          # sort by size, biggest last
alias lc="ls -ltcr"         # sort by and show change time, most recent last
alias lu="ls -ltur"         # sort by and show access time, most recent last
alias lt="ls -ltr"          # sort by date, most recent last
alias lm="ls -Al |more"     # pipe through 'more'
alias lr="ls -lR"           # recursive ls
alias lsr="tree -Csu"       # nice alternative to 'recursive ls'

# Network
#-------------------------------------
alias pong="ping -c 3 google.com"
alias wifi="sudo wifi-menu"
alias edu='sudo netctl start eduroam'
alias odd='sudo netclt stat wlp2s0-Oudedijk3A03'
alias cp3='sudo netctl start wlp2s0-Composer3\(2.4GHz\)'
alias cp4='sudo netctl start wlp2s0-Composer4\(2.4GHz\)'

# Media
#-------------------------------------
alias mp="ncmpcpp"

# Convenience
#-------------------------------------
mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2" }
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias say="fortune | cowsay -f tux"
alias vbmod="sudo modprobe vboxdrv"
alias upterm='xrdb $HOME/.Xresources'
alias rm='rm -iv'
alias fn='sudo find / -name'
alias mpvw="mpv --aspect=16:9"
alias fmnt="findmnt"
alias cd..="cd .."

# Scrott
#-------------------------------------
# alias scrot="scrot $HOME/pictures/screenshots/%Y-%m-%d-%T-screenshot.png"

# GPG
#-------------------------------------
alias fp="gpg --list-keys --fingerprint"

# Scripts
#-------------------------------------
alias fs="sudo ~/scripts/./auto-mount.sh"
alias color="$HOME/scripts/./color.sh"
alias inf="$HOME/scripts/./info.sh"
alias toad="$HOME/scripts/./hypnotoad.pl"

# Code & file editing related
#-------------------------------------
alias code="cd $HOME/documents/code"
alias tx="tmux -f ~/.config/tmux/conf"

# Viewers
#-------------------------------------
alias z='zathura'

# Mail
#-------------------------------------
alias m="mutt -F ~/.config/mutt/muttrc"
alias mail="m"

# Editor
#-------------------------------------
alias awrc='$EDITOR $HOME/.config/awesome/rc.lua'
alias awtheme='$EDITOR $HOME/.config/awesome/themes/miro/theme.lua'
alias ve='vim -u ~/.vimencrypt -x'
alias vi="vim"

# Homestead
#-------------------------------------
alias hssh="homestead ssh"
alias hsup="homestead up"
alias hspr="homestead provision"

# Pacman
#-------------------------------------
alias pacman='sudo pacman --color always'
alias pac='pacman --color always'
alias pacs='sudo pacman -S'
alias pacss='pacman -Ss'
alias pacsi='pacman -Si'
alias pacssi='pacman -Ssi'
alias pacqs='pacman -Qs'
alias pacqi='pacman -Qi'
alias pacqsi='pacman -Qsi'
alias pacqssi='pacman -Qssi'
alias pacup="sudo pacman -Syu"
alias pacremove="sudo pacman -Rns"
alias orphans="pacman -Qtdq"
alias pacr='sudo pacman -Rscudn'
alias upmirrors='sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup; sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist'
alias pacc="sudo paccache -r"
alias pacca="sudo paccache -ruk0"

# History
#-------------------------------------
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=10000
export SAVEHIST=$((HISTSIZE/2))
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Run bash files
autoload bashcompinit
bashcompinit

# Source highlighting
#-------------------------------------
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Multiple command functions
# -----------------------------------
