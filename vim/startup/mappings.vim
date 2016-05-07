" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/mappings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
" ----------------------------------------------------

" Keep cursor centered
" ----------------------------------------------------
nnoremap j jzz
nnoremap k kzz

" Indent everything
" ----------------------------------------------------
nnoremap <C-i> gg=G

" Allows writing to files with root priviledges
" ----------------------------------------------------
cmap w!! w !sudo tee % > /dev/null

" space bar un-highlights search
" ----------------------------------------------------
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" command to pull image URL
" ----------------------------------------------------
:command -nargs=1 Url :read !vimgurl <args>

" I really hate that things don't auto-center
" ----------------------------------------------------
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" Navigation up or down is really up or down
" ----------------------------------------------------
nnoremap j gj
nnoremap k gk

" Quick Pairs
" ----------------------------------------------------
ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
ino {<CR> {<CR>}<ESC>O

"  Comment visually selected text
" ----------------------------------------------------
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" Insert current date and time
" ----------------------------------------------------
nnoremap ,d "=strftime("%d %b, %Y %X")<CR>p

" Change to current directory
" ----------------------------------------------------
nnoremap cd :cd %:p:h<CR>:pwd<CR>

" Allow all window commands in insert mode
" ----------------------------------------------------
imap <C-w> <C-o><C-w>

" Map for save & quit operations
" ----------------------------------------------------
nnoremap ,q :q!<CR>
nnoremap ,w :w!<CR>

" Yank file path
" ----------------------------------------------------
nmap cp :let @+ = expand("%")<CR>

" Map sort function to a key
" ----------------------------------------------------
vnoremap s :sort<CR>

" Easier moving of code blocks (better indentation)
" ----------------------------------------------------
vnoremap < <gv
vnoremap > >gv

" Easier management of code
" ----------------------------------------------------
nnoremap go o<ESC>k
nnoremap gO O<ESC>j

" Window splitting
" ----------------------------------------------------
nnoremap ,v :vsplit<CR>
nnoremap ,h :split<CR>

" Tabs
" ----------------------------------------------------
nnoremap gn :tabnew<CR>

" Window resizing mappings (ALT KEY)
" ----------------------------------------------------
execute "set <M-h>=\eh"
nnoremap <M-h> :vertical resize -5<cr>
execute "set <M-j>=\ej"
nnoremap <M-j> :resize +5<cr>
execute "set <M-k>=\ek"
nnoremap <M-k> :resize -5<cr>
execute "set <M-l>=\el"
nnoremap <M-l> :vertical resize +5<cr>
execute "set <M-0>=\e0"
nnoremap <M-0> <C-w>=

" Switch between window with vi keybindings
" ----------------------------------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fast navigation
" ----------------------------------------------------
nnoremap m :MRU<CR>
nnoremap ; :

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" ----------------------------------------------------
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endi

" Familiar commands for file/browsing (CTRL-P)
" --------------------------------------------------
map <C-P> :CtrlPBufTag<cr>

" I don't want to pull up these folders/files when calling CtrlP
" --------------------------------------------------
set wildignore+=*/vendor/**
set wildignore+=*/public/**

" Edit todo list for project
" ----------------------------------------------------
nmap todo :e todo.txt<CR>

" Auto-remove trailing spaces
" ----------------------------------------------------
autocmd BufWritePre *.php :%s/\s\+$//e

" Create/edit file in the current directory
" ----------------------------------------------------
nmap :ed :edit %:p:h/

" Tagbar
" ----------------------------------------------------
nmap <F2> :TagbarToggle<cr>

" NERDTree
" ----------------------------------------------------
map <C-b> :NERDTreeToggle<CR>

" Keys & functions
" ----------------------------------------------------
command! -nargs=+ MapToggle call MapToggle(<f-args>)
:nnoremap <F4> :buffers<CR>:buffer<Space>
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap
" vim: ft=vim
