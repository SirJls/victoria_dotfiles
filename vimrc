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

" Vim mail client interface
" Plugin 'felipec/notmuch-vim'

" Distractfree reading
" Plugin 'junegunn/goyo.vim'

" Let me match more characters
" Plugin 'tmhedberg/matchit'

" Surround t-pope quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'

" Add Tcomments for comments
Plugin 'tomtom/tcomment_vim'

" Add powerline
" Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" Let me use the f
Plugin 'dahu/vim-fanfingtastic'

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

" XSbeats
Plugin 'xsbeats/vim-blade'

" Control p
Plugin 'kien/ctrlp.vim'

" Omnicompleter
Plugin 'shawncplus/phpcomplete.vim'

" Fast navigation
Plugin 'yegappan/mru'

call vundle#end()

"========== Filetype stuff on ========
syntax on
filetype plugin on
filetype indent on
filetype plugin indent on

"========== Load custom settings =====
source ~/.vim/startup/settings.vim
source ~/.vim/startup/functions.vim
source ~/.vim/startup/mappings.vim
