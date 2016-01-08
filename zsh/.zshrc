# ----------------------------------------------------
# file: $HOME/dotfiles/zsh/zshrc
# author    jls - http://sjorssparreboom.nl
# vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
# ----------------------------------------------------

# Autoload & colours
# ----------------------------------------------------
autoload -U colors && colors
zmodload zsh/complist

# Autostartx
# ----------------------------------------------------
[[ $(tty) = "/dev/tty1" ]] && exec startx

# Prompts
# ----------------------------------------------------
LPROMPT () {
PS1=""
PS1+="┌─[%{$fg[magenta]%}%m%{$fg_bold[blue]%}"
# PS1+="[%T]%F{red}%(?.. exited %1v)%F{reset}"
PS1+="%F{yellow}${vcs_info_msg_0_}%F{reset}"
PS1+="%~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
└─╼ "
}

# Set and configure ssh agent
# ----------------------------------------------------
if ! pgrep -u $USER ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval $(<~/.ssh-agent-thing) 1>/dev/null
fi
ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'

# Show vi mode
# ----------------------------------------------------
function zle-line-init zle-keymap-select {
    RPS1="%{$fg[yellow]%}${${KEYMAP/vicmd/%B Command Mode %b}/(main|viins)/ }%{$reset_color%}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function precmd {
   vcs_info
   LPROMPT
}

PROMPT_EOL_MARK=" •"

# completions
# add custom completion scripts
# ----------------------------------------------------
fpath=(~/.zsh/completion $fpath) 
autoload -Uz compinit
compinit

zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle -e ':completion:*' hosts 'reply=(cent pi sent veles)'
zstyle :compinstall filename '$HOME/zsh/.zshrc'

# avoid duplicate params completion in cp, mv, rm
# ----------------------------------------------------
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# History
# ----------------------------------------------------
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=10000
export SAVEHIST=$((HISTSIZE/2))
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# edit history
# ----------------------------------------------------
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

setopt autocd extendedglob nomatch completealiases
setopt correct                                             # try to correct spelling
setopt no_correctall                                       # …only for commands, not filenames

# keybinds
# ----------------------------------------------------
bindkey -v
KEYTIMEOUT=1

# fix for cursor position
# ----------------------------------------------------
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# prevent protected characters
# ----------------------------------------------------
zle -A kill-whole-line vi-kill-line
zle -A backward-kill-word vi-backward-kill-word
zle -A backward-delete-char vi-backward-delete-char

bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "\e." insert-last-word
bindkey "\eq" quote-line
bindkey "\ek" backward-kill-line

# use the vi navigation keys in menu completion
# ----------------------------------------------------
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# manual pages for current command
# ----------------------------------------------------
bindkey "^[h" run-help

# quoting URLs
# ----------------------------------------------------
autoload -U url-quote-magic
zstyle ':urlglobber' url-other-schema ftp git http https magnet
zstyle ':url-quote-magic:*' url-metas '*?[]^(|)~#='
zle -N self-insert url-quote-magic

# colour coreutils
# ----------------------------------------------------
export GREP_COLOR="1;31"

# colors for ls
# ----------------------------------------------------
if [[ -f ~/dotfiles/dir_colors ]]; then
    eval $(dircolors -b ~/.dir_colors)
fi
# to run bash functions
# ----------------------------------------------------
autoload bashcompinit
bashcompinit

# command not found hook
# ----------------------------------------------------
source $HOME/.zsh/command-not-found.zsh

# source highlighting
# ----------------------------------------------------
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# functions
# ----------------------------------------------------
if [[ -d "$ZDOTDIR" ]]; then
  for file in "$ZDOTDIR"/*.zsh; do
    source "$file"
  done
fi
