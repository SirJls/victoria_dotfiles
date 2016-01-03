# ----------------------------------------------------
# file: $HOME/dotfiles/zsh/aliases.zsh
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
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
alias edu='sudo netctl start eduroam'
alias odd='sudo netctl start wlp2s0-Oudedijk3A03'
alias cp3='sudo netctl start wlp2s0-Composer3\(2.4GHz\)'
alias cp4='sudo netctl start wlp2s0-Composer4\(2.4GHz\)'

# media
# ----------------------------------------------------
alias mp="ncmpcpp"

# convenience
# ----------------------------------------------------
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

# GPG
# ----------------------------------------------------
alias fp="gpg --list-keys --fingerprint"

# scripts
# ----------------------------------------------------
alias fs="sudo ~/scripts/./auto-mount"
alias color="$HOME/scripts/./color"
alias inf="$HOME/scripts/./info"
alias toad="$HOME/scripts/./hypnotoad"
alias xdg="$HOME/scripts/xdg"

# code & file editing related
# ----------------------------------------------------
alias code="cd $HOME/code"
alias tx="tmux -f ~/.config/tmux/conf"

# viewers
# ----------------------------------------------------
alias z='zathura'

# mail
# ----------------------------------------------------
# alias m="mutt -F ~/.config/mutt/muttrc"
alias m='mutt'
alias abook="abook --config $HOME/sync/abook/abookrc --datafile $HOME/sync/abook/addressbook"

# editor
# ----------------------------------------------------
alias awrc='$EDITOR $HOME/.config/awesome/rc.lua'
alias awtheme='$EDITOR $HOME/.config/awesome/themes/miro/theme.lua'
alias ve='vim -u ~/.vimencrypt -x'
alias vi="vim"

# homestead
# ----------------------------------------------------
alias hssh="homestead ssh"
alias hsup="homestead up"
alias hspr="homestead provision"

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
