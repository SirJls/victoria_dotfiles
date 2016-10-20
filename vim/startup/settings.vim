" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/settings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:et:sw=4:ts=4:tw=78:
" ----------------------------------------------------

" The actual settings
" ----------------------------------------------------
set encoding=utf-8                      " UTF-8 encoding for all new files
set ttyfast                             " don't lag...
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
" set spelllang=en_gb                     " real English spelling
set spelllang=nl                        " real Dutch spelling
set dictionary+=/usr/share/dict/words
set wmh=0                               " no displaying current line for minimized files
set nofoldenable                        " disable folding
set timeoutlen=1000                     " faster
set ttimeoutlen=10                      " faster
set mouse=a                             " let me use the mouse (on special ocassions)
set pdev=Canon-MP2900-series            " setup the printer

let mapleader='\'                       " Bind/set leader key
let g:is_posix=1                        " POSIX shell scripts
let g:loaded_matchparen=1               " disable parenthesis highlighting
let g:is_bash=1                         " bash syntax the default for highlighting
let g:vimsyn_noerror=1                  " hack for correct syntax highlighting

" speedup
" ----------------------------------------------------
set nocursorcolumn                      " do not highlight column
set nocursorline                        " do not highlight line
syntax sync minlines=256                " start highlighting from 256 lines backwards
set synmaxcol=300                       " do not highligth very long lines
set re=1                                " use explicit old regexpengine, seems to be more faster

" tabs and indenting
" ----------------------------------------------------
set modeline
set linespace=2
set tabstop=2                           " tabs appear as n number of columns
set softtabstop=2
set noexpandtab
set shiftwidth=2                        " n cols for auto-indenting
" set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line
set copyindent                          " copy the previous indentation on autoindenting

" Splits
" ----------------------------------------------------
set splitbelow
set splitright

" searching
" ----------------------------------------------------
set hlsearch                            " highlight all search results
set incsearch                           " increment search
set ignorecase                          " case-insensitive search
set smartcase                           " uppercase causes case-sensitive search

" Extended Text Objects
" ----------------------------------------------------
let s:items = [ "<bar>", "\\", "/", ":", ".", "*", "_" ]
for item in s:items
    exe "nnoremap yi".item." T".item."yt".item
    exe "nnoremap ya".item." F".item."yf".item
    exe "nnoremap ci".item." T".item."ct".item
    exe "nnoremap ca".item." F".item."cf".item
    exe "nnoremap di".item." T".item."dt".item
    exe "nnoremap da".item." F".item."df".item
    exe "nnoremap vi".item." T".item."vt".item
    exe "nnoremap va".item." F".item."vf".item
endfor

" listchars
" ----------------------------------------------------
set list listchars=trail:·,precedes:«,extends:»,tab:▸\

" status bar info and appearance
" ----------------------------------------------------
set statusline=\%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [wc:%{WordCount()}]\ ::\ [%p%%:\ %l/%c/%L]
set laststatus=2
set cmdheight=1
set shortmess=a

" default to very magic
" ----------------------------------------------------
no / /\v

" Load colorscheme
" ----------------------------------------------------
colorscheme PaperColor

if has("nvim")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1       " True gui colors in terminal
else
    set ttyscroll=3                         " don't lag...
    set t_Co=256
endif

" vimdiff the tool for the job
" ----------------------------------------------------
if &diff
    set diffopt=filler,foldcolumn:0
endif

" Utlisnips, because it's awesome
" ----------------------------------------------------
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsSnippetsDir = "/home/enigma/dotfiles/vim/snips/"
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<c-l>"

" Deoplete
" ----------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#auto_complete_start_length = 1

" Set autocmd command && groups
" ----------------------------------------------------
augroup filetypes
    au!

    " follow symlink and set working directory
    au BufRead *
        \ call FollowSymlink() |
        \ call SetProjectRoot()

    au BufRead,BufNewFile,BufWrite *.tex,*latex set ft=tex
    au BufNewFile,BufRead,BufWrite *.csv setlocal ft=csv
    au BufNewFile,BufRead,BufWrite *.conf setlocal ft=conf set tw=79 fo=cqt wm=0
    au BufRead,BufWrite,BufNewFile *.txt,*.md,*.text,*.tex set spell tw=79 fo=cqt wm=0

    au Filetype tex,latex syntax spell toplevel

    au FileType xml set equalprg=xmllint\ --format\ --recover\ -

    au FileType javascript,coffee setlocal ts=2 sts=-1 sw=2 et ai
    au FileType ruby,eruby setlocal ts=2 sts=-1 sw=2 et ai 
    au FileType ruby,erub compiler ruby

    au FileType haskell, setlocal ts=8 sts=4 sw=4 sr et ai

augroup end

" latex
" ----------------------------------------------------
let g:tex_comment_nospell= 1

" extras
" ----------------------------------------------------
if has("autocmd")
    " always jump to the last cursor position
    au BufReadPost * if line("'\"")>0 && line("'\"")<=line("$") | exe "normal g`\""|endif
    au BufRead,BufNewFile ~/.mutt/temp/mutt-* set ft=mail wrap lbr nolist spell wm=0
    au BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'nvim | " . expand("%:t") . "'")
endif

" vim: ft=vim
