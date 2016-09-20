"-------------------------------------
" file: $HOME/.vimrc
"-------------------------------------
"=========== Filetype stuff off ======
syntax off
filetype plugin off
filetype indent off

"========== Load Plugs =============

" set the runtime path to include Plugged and initialize

call plug#begin('~/dotfiles/vim/plugged')

" vim-matchit
Plug 'edsono/vim-matchit'

" Ruby for vim!
Plug 'vim-ruby/vim-ruby'

" Show the git diff in the gutter
Plug 'airblade/vim-gitgutter'

" Surround t-pope quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Show color for the color codes
Plug 'Colorizer'

" Ack for vim
Plug 'mileszs/ack.vim'

" Deoplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Track engine for snippets
Plug 'SirVer/UltiSnips'

" Paper colorscheme
Plug 'NLKNguyen/papercolor-theme'

" Fast navigation
Plug 'yegappan/mru'

call plug#end()

"========== Filetype stuff on ========
syntax on
filetype plugin on
filetype plugin indent on

"========== Load custom settings =====
source ~/.vim/startup/settings.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
