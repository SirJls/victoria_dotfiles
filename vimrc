"-------------------------------------
" file: $HOME/.vimrc
"-------------------------------------
"=========== Filetype stuff off ======
syntax off
filetype plugin off
filetype indent off

"========== Load Plugins =============

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" vim-matchit
Plugin 'edsono/vim-matchit'

" vim R plugin
Plugin 'vim-scripts/Vim-R-plugin'

" Surround t-pope quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

" Let me use the f
Plugin 'dahu/vim-fanfingtastic'

" Dependency for fanfingtastic
Plugin 'tpope/vim-repeat'

" Show color for the color codes
Plugin 'Colorizer'

" YouCompeleteMe (YCM)
Plugin 'Valloric/YouCompleteMe'

" Track engine for snippets
Plugin 'SirVer/UltiSnips'

" Syntaxchecker
Plugin 'scrooloose/syntastic'

" Tagbar
Plugin 'majutsushi/tagbar'

" NERDTree
Plugin  'scrooloose/nerdtree'

" Control p
Plugin 'kien/ctrlp.vim'

" Fast navigation
Plugin 'yegappan/mru'

call vundle#end()

"========== Filetype stuff on ========
syntax on
filetype plugin on
filetype plugin indent on

"========== Load custom settings =====
source ~/.vim/startup/settings.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
