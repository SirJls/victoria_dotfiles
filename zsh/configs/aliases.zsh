# ----------------------------------------------------
# file: $HOME/dotfiles/zsh/aliases.zsh
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=zsh:
# ----------------------------------------------------

# colour coreutils
# ----------------------------------------------------
alias grep="grep --color=auto"
alias "ls=ls --color=auto"

# the 'ls' family
# ----------------------------------------------------
alias ll="ls -l --group-directories-first"
alias ls="ls -h --color"                                    # add colors for filetype recognition
alias la="ls -A"                                            # show hidden files
alias lx="ls -xb"                                           # sort by extension
alias lk="ls -lSr"                                          # sort by size, biggest last
alias lc="ls -ltcr"                                         # sort by and show change time, most recent last
alias lu="ls -ltur"                                         # sort by and show access time, most recent last
alias lt="ls -ltr"                                          # sort by date, most recent last
alias lm="ls -Al |more"                                     # pipe through 'more'
alias lr="ls -lR"                                           # recursive ls
alias lsr="tree -Csu"                                       # nice alternative to 'recursive ls'

# network
# ----------------------------------------------------
alias pong="ping -c 3 google.com"
alias wifi="sudo wifi-menu"
alias edu='python $HOME/scripts/edu && sudo netctl start eduroam'

# convenience
# ----------------------------------------------------
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias say="fortune | cowsay -f tux"
alias vbmod="sudo modprobe vboxdrv"
alias upterm='xrdb $HOME/.Xresources'
alias rm='rm -iv'
alias mpvw="mpv --video-aspect=16:9"
alias cd..="cd .."
alias dush="du -sm *|sort -n|tail"
alias makeup="updpkgsums && makepkg -ci"
alias irc="rm -f $HOME/.irssi/saved_colors && irssi"
alias printers="system-config-printer"
alias zreload="rm -f ~/dotfiles/zsh/.zcompdump* && . ~/.zsh/.zshrc autload -Ux compinit compinit"

# management
# ----------------------------------------------------
alias grpall="cut -d: -f1 /etc/group"
alias usrall="cut -d: -f1 /etc/passwd"

# audio management
# ----------------------------------------------------
alias audio="pacmd list-cards"
alias hdmi="pacmd set-card-profile 1 off; pacmd set-card-profile 0 output:hdmi-stereo-extra1"
alias analog="pacmd set-card-profile 0 off; pacmd set-card-profile 1 output:analog-stereo+input:analog-stereo"
alias alsamixer="alsamixer -g"
alias mixer="alsamixer"

# thefuck plugin for zsh
# ----------------------------------------------------
eval $(thefuck --alias)

# vpn
# ----------------------------------------------------
alias vpn="sudo ip route add default dev ppp0"

# GPG
# ----------------------------------------------------
alias fp="gpg --list-keys --fingerprint"

# code & file editing related
# ----------------------------------------------------
alias tx="tmux -f ~/.tmux/conf"

# viewers
# ----------------------------------------------------
alias z='zathura $1 --fork'

# editor
# ----------------------------------------------------
alias ve='vim -u ~/.vimencrypt -x'

if hash nvim 2>/dev/null; then
  alias vim='nvim'
  alias vimdiff='nvim -d'
fi

alias vi="vim"
alias v="vim"

# pacman
# ----------------------------------------------------
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
