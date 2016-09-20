" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/mappings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
" ----------------------------------------------------

" Keep cursor centered
" ----------------------------------------------------
nnoremap j jzz
nnoremap k kzz

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
ino ` ``<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
ino {<CR> {<CR>}<ESC>O

" help in new tab
" ----------------------------------------------------
cabbrev help tab help

" Let me escape!
" ----------------------------------------------------
inoremap <leader><space> \ 

" Insert current date and time
" ----------------------------------------------------
nnoremap <leader>D "=strftime("%d %b, %Y %X")<CR>p

" Change to current directory
" ----------------------------------------------------
nnoremap cd :cd %:p:h<CR>:pwd<CR>

" Map for save & quit operations
" ----------------------------------------------------
nnoremap gq :q!<CR>
nnoremap gw :w!<CR>

" Yank file path
" ----------------------------------------------------
nmap yp :let @+ = expand("%")<CR>

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

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" ----------------------------------------------------
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endi

" Keys & functions
" ----------------------------------------------------
command! -nargs=+ MapToggle call MapToggle(<f-args>)
:nnoremap <F4> :buffers<CR>:buffer<Space>
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap

" Use dmenu with vim so it sucksless
" ----------------------------------------------------
map <c-t> :call DmenuOpen("tabe")<cr>
map <c-f> :call DmenuOpen("e")<cr>

" Fast navigation
" ----------------------------------------------------
nnoremap m :MRU<CR>

" Abbreviations
" ----------------------------------------------------
iab mymail mail@sjorssparreboom.nl
iab myname sjors sparreboom
iab mysite http://sjorssparreboom.nl
iab myalias git-jls

" vim: ft=vim
