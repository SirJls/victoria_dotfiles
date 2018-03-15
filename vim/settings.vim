" -- Meta ---------------------------------------------------------------------
" -- File:   ${DOTFILES}/vim/settings.vim
" -- Author: SirJls - http://sjorssparreboom.nl
" -----------------------------------------------------------------------------

" -- General ------------------------------------------------------------------

set t_Co=256
set encoding=utf-8
set fileencoding=utf-8
set ttyfast
set lazyredraw
set cursorline
set nowrap
set number
set modifiable
set noshowmatch
set backspace=2
set scrolloff=10
set ww=b,s,h,l,<,>,[,]
set linebreak
set wildmenu
set wildmode=list:longest,full
set spellfile=$DOTFILES/vim/spell/en.utf-8.add
set spelllang=en_gb
set dictionary+=/usr/share/dict/words
set wmh=0
set timeoutlen=500
set mouse=a
set pdev=Canon-MP2900-series
set clipboard=unnamed

" -- Backups ------------------------------------------------------------------

set backupdir=$DOTFILES/vim/backup/                  " backup files directories
set directory=$DOTFILES/vim/backup/                  " store backup swp files

" -- Indentation --------------------------------------------------------------

let g:is_posix=1
let g:loaded_matchparen=1
let g:is_bash=1
let g:vimsyn_noerror=1

set modeline
set textwidth=79
set linespace=2
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set autoindent
set copyindent

" -- Searching ----------------------------------------------------------------

set hlsearch
set incsearch
set ignorecase
set smartcase
set path+=**

" -- Speed up -----------------------------------------------------------------

set nocursorcolumn
set nocursorline
set ttyscroll=3

" -- Statusline ---------------------------------------------------------------

set statusline=\%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [wc:%{WordCount()}]\ ::\ [%p%%:\ %l/%c/%L]
set list listchars=trail:·,precedes:«,extends:»,tab:▸·
set shortmess=a
set laststatus=2

" -- Autocommands -------------------------------------------------------------

augroup files
  au!
  au BufRead,BufNewFile *.h,*c setlocal ft=c ts=8 sw=8 sta ai noet
  au FileType cmake setlocal ts=4 sw=4 sta ai et
  au FileType cs setlocal ts=4 sw=4 sta ai et
  au BufRead,BufNewFile *.hs setlocal ts=8 sts=4 sw=4 et sr
  au BufRead,BufNewFile *.fs setlocal ts=8 sts=4 sw=4 et sr
augroup end

augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

augroup end

" -- OmniSharp ----------------------------------------------------------------

let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_selector_ui = 'fzf'       " Use fzf.vim

" -- Haskell ------------------------------------------------------------------

let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:ycm_semantic_triggers =  {
  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go,haskell' : ['.'],
  \ }


" -- Completion ---------------------------------------------------------------

set splitbelow
set updatetime=500
set cmdheight=1
set hidden
set pumheight=10                          " so the complete menu doesn't get too big
set completeopt=menu,longest              " menu, menuone, longest and preview

" -- Clang --------------------------------------------------------------------

let g:clang_complete_auto=1               " I can start the autocompletion myself, thanks..
let g:clang_snippets=1                    " use a snippet engine for placeholders
let g:clang_snippets_engine='ultisnips'
let g:clang_auto_select=2                 " automatically select and insert the first match

" -- Syntastic ----------------------------------------------------------------

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_loc_list_height = 3

" -- FZF ----------------------------------------------------------------------

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.fzf/fzf-history'

" -- UltiSnips ----------------------------------------------------------------

let g:UltiSnipsListSnippets ="<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-x>"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsSnippetsDir = $SNIPPETS_DIR . "/ultisnips"

" -- Colorizer ----------------------------------------------------------------

let g:colorizer_maxlines = 1000

" -- YCM ----------------------------------------------------------------------

let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" -- Night/Day ----------------------------------------------------------------

let g:nd_themes = [
  \ ['8:00',  'seagull', 'light' ],
  \ ['20:00', 'petrel',  'dark' ],
  \ ]

" vim:set ft=vim et sw=2 ts=2 tw=79:
