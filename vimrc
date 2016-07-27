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

" vim R plugin
Plug 'vim-scripts/Vim-R-plugin'

" Go plugin
Plug 'fatih/vim-go'

" Comment lines
Plug 'tpope/vim-commentary'

" Show the git diff in the gutter
Plug 'airblade/vim-gitgutter'

" Surround t-pope quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Show color for the color codes
Plug 'Colorizer'

" YouCompeleteMe (YCM)
" Plug 'Valloric/YouCompleteMe'

" Deoplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-clang'

" Track engine for snippets
Plug 'SirVer/UltiSnips'

" Paper colorscheme
Plug 'NLKNguyen/papercolor-theme'

" Tagbar
Plug 'majutsushi/tagbar'

" Colorschemes
Plug 'flazz/vim-colorschemes'

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
