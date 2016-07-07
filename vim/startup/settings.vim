" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/settings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:et:sw=4:ts=4:tw=78:ft=vim
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
set spelllang=en_gb                     " real English spelling
set dictionary+=/usr/share/dict/words
set wmh=0                               " no displaying current line for minimized files
set nofoldenable                        " disable folding
set timeoutlen=1000                     " faster
set ttimeoutlen=10                      " faster
set mouse=a                             " let me use the mouse (on special ocassions)
set pdev=Canon-MP620-series             " setup the printer

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
set synmaxcol=300                       " do not highlith very long lines
set re=1                                " use explicit old regexpengine, seems to be more faster

" fix spell check not always working in tex documents
" ----------------------------------------------------
syn sync maxlines=200
syn sync minlines=50

" Auto commands
" ----------------------------------------------------
au FileType c,cpp,go setlocal comments-=:// comments+=f://

" tabs and indenting
" ----------------------------------------------------
set modeline
set linespace=2
set tabstop=8                           " tabs appear as n number of columns
set softtabstop=8
set noexpandtab
set shiftwidth=8                        " n cols for auto-indenting
" set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line
set copyindent                          " copy the prevois indentation on autoindenting

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

" Set default filetype to txt
" ----------------------------------------------------
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

" Add spell for LaTeX documents
" ----------------------------------------------------
autocmd FileType tex setlocal spell spelllang=en_gb

" All tex files as tex
" ----------------------------------------------------
let g:tex_flavor = "latex"
set suffixes+=.log,.aux,.bbl,.blg,.idx,.ilg,.ind,.out,.pdf

" Associate blade with html, php
" ----------------------------------------------------
autocmd BufNewFile,BufRead *.php set ft=html | set ft=php
autocmd BufNewFile,BufRead *.blade.php set ft=blade.html.php
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Let Ctags look recursively down to $HOME/code
" ----------------------------------------------------
set tags=./tags,tags;$HOME/code

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
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$") | exe "normal g`\""|endif

    " settings for specific filetypes
    autocmd BufRead *.txt set tw=79
    autocmd BufRead *.tex,*.markdown,*.md,*.txt set spell
    autocmd BufRead,BufNewFile ~/.mutt/temp/mutt-* set ft=mail wrap lbr nolist spell wm=0
endif

" Load colorscheme
" ----------------------------------------------------
colorscheme easy-reading

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
let g:UltiSnipsSnippetsDir = "/home/jls/dotfiles/vim/snips/"
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<c-e>"

" Uncomment if you use (YCM)
" YouCompleteMe (YCM) 
" ----------------------------------------------------
" let g:ycm_confirm_extra_conf    = 0
" let g:ycm_complete_in_comments  = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
" let g:ycm_extra_conf_vim_data   = ['&filetype']
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_filetype_blacklist = { 'help': 1 }
" let g:ycm_disable_for_files_larger_than_kb = 500

" Deoplete
" ----------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_ignore_case = 1 
let g:deoplete#auto_complete_start_length = 1
call deoplete#custom#set('buffer', 'rank', 9999)
call deoplete#custom#set('ultisnips', 'rank', 9999)

" libclang for neovim
" ----------------------------------------------------
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header ="/usr/include/clang/"

" Go environment setting
" ----------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" tmux
" ----------------------------------------------------
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'nvim | " . expand("%:t") . "'")

" vim: ft=vim
