" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/settings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=vim:
" ----------------------------------------------------

" The actual settings
" ----------------------------------------------------
set encoding=utf-8                      " UTF-8 encoding for all new files
set ttyfast                             " don't lag...
set ttyscroll=3                         " don't lag...
set lazyredraw                          " to avoid scrolling problems
set cursorline                          " track position
set nocompatible                        " leave the old ways behind…
set nowrap                              " don't wrap lines
"set nobackup                            " disable backup files (filename~)
set number                              " show line numbers
set modifiable                          " make the bufer modifiable
set backupdir=~/.vim/backup/            " backup files directories
set directory=~/.vim/backup/            " store backup swp files set splitbelow
set showmatch                           " matching brackets & the like
set clipboard=unnamedplus               " yank and copy to X clipboard
set backspace=2                         " full backspacing capabilities (indent,eol,start)
set scrolloff=10                        " keep 10 lines of context
set ww=b,s,h,l,<,>,[,]                  " whichwrap -- left/right keys can traverse up/down
set linebreak                           " attempt to wrap lines cleanly
set wildmenu                            " enhanced tab-completion shows all matching cmds in a popup menu
set wildmode=list:longest,full          " full completion options
set spelllang=en_gb                     " real English spelling
set wmh=0                               " no displaying current line for minimized files
set nofoldenable                        " disable folding
au WinEnter * set nofen                 " disable disable DISABLE!
au WinLeave * set nofen                 " disable disable DISABLE!
set timeoutlen=1000                     " faster
set ttimeoutlen=10                      " faster
set mouse=a                             " let me use the mouse (on special ocassions)
set pdev=Canon-MP620-series             " setup the printer

let g:fanfingtastic_ignorecase = 1      " ignore case with f
let mapleader='\'                       " Bind/set leader key
let g:is_posix=1                        " POSIX shell scripts
let g:loaded_matchparen=1               " disable parenthesis highlighting
let g:is_bash=1                         " bash syntax the default for highlighting
let g:vimsyn_noerror=1                  " hack for correct syntax highlighting


" Colors
" ----------------------------------------------------
set t_Co=256

" tabs and indenting
" ----------------------------------------------------
set tabstop=4                           " tabs appear as n number of columns
set shiftwidth=4                        " n cols for auto-indenting
set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line
set copyindent                          " copy the prevois indentation on autoindenting
set linespace=15                        " set the linespace

" Splits
" ----------------------------------------------------
set splitbelow
set splitright
" set winheight=30                        " make current window 30 lines
" set winminheight=5

" searching
" ----------------------------------------------------
set hlsearch                            " highlight all search results
set incsearch                           " increment search
set ignorecase                          " case-insensitive search
set smartcase                           " uppercase causes case-sensitive search

" Associate blade with html, php
" ----------------------------------------------------
autocmd BufNewFile,BufRead *.php set ft=html | set ft=php
autocmd BufNewFile,BufRead *.blade.php set ft=blade.html.php

" Let Ctags look recursively down to $HOME
" ----------------------------------------------------
set tags=./tags,tags;$HOME

" listchars
" ----------------------------------------------------
set list listchars=trail:·,precedes:«,extends:»,tab:▸\

" status bar info and appearance
" ----------------------------------------------------
set statusline=\%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [wc:%{WordCount()}]\ ::\ [%p%%:\ %l/%c/%L]
set laststatus=2
set cmdheight=1

" default to very magic
" ----------------------------------------------------
no / /\v

" Autocmd
" ----------------------------------------------------
if has("autocmd")
    " always jump to the last cursor position
    " ----------------------------------------------------
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$") | exe "normal g`\""|endif

    " settings for specific filetypes
    " ----------------------------------------------------
    autocmd BufRead *.txt set tw=79
    autocmd BufRead *.tex,*.markdown,*.md,*.txt set spell
    autocmd BufRead,BufNewFile ~/.mutt/temp/mutt-* set ft=mail wrap lbr nolist spell wm=0
endif

" Load colorschemes
" ----------------------------------------------------

if exists('$WINDOWID') && (&term =~ "termite" || &term =~ "tmux")
    colorscheme miromiro
else
    colorscheme miro8                   " colourscheme for the 8 colour linux term
endif

" vimdiff
" ----------------------------------------------------
if &diff
    set diffopt=filler,foldcolumn:0
endif

" Utlisnips config so it does't conflict with YCM
" ----------------------------------------------------
let g:ycm_key_list_select_completion=["<tab>"]
let g:ycm_key_list_previous_completion=["<S-tab>"]
let g:UltiSnipsJumpForwardTrigger="["
let g:UltiSnipsJumpBackwardTrigger="]"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0
let g:UltiSnipsSnippetsDir = "/home/jls/dotfiles/vim/snips/"
let g:UltiSnipsSnippetDirectories=["snips"]


" YouCompleteMe (YCM)
" ----------------------------------------------------
let g:ycm_confirm_extra_conf    = 0
let g:ycm_complete_in_comments  = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_filetype_blacklist = { 'help': 1 }

" NERDTree
" ----------------------------------------------------
map <C-b> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1

" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Store the bookmarks file
" ----------------------------------------------------
let NERDTreeBookmarksFile=expand("$HOME/.vim/vim-NERDTreeBookmarks")

" Show the bookmarks table on startup
" ----------------------------------------------------
let NERDTreeShowBookmarks=1
let NERDTreeModifiable=1

" tmux
" ----------------------------------------------------
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim | " . expand("%:t") . "'")

" vim: ft=vim
