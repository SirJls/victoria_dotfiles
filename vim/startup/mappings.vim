" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/mappings.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
" ----------------------------------------------------

" Keep cursor centered
" ----------------------------------------------------
nnoremap j jzz
nnoremap k kzz

" Jump out of parenthesis
" ----------------------------------------------------
inoremap <leader>e <C-o>a<space>

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

" Helpers
" ----------------------------------------------------
noremap <leader>a =ip
noremap cp yap<S-}>p

nnoremap Q @q
vnoremap Q :norm @q<cr>

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

" Window splitting
" ----------------------------------------------------
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>

" Tabs
" ----------------------------------------------------
nnoremap ,t :tabnew<CR>

" Window resizing mappings (ALT KEY)
" ----------------------------------------------------
if has("nvim")
    nnoremap <a-h> :vertical resize -5<cr>
    nnoremap <a-j> :resize +5<cr>
    nnoremap <a-k> :resize -5<cr>
    nnoremap <a-l> :vertical resize +5<cr>
    nnoremap <a-0> <C-w>=
else
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
endif

" Allow all window commands in insert mode
" ----------------------------------------------------
" imap <C-w> <C-o><C-w>
" imap <s-h> <c-o><c-w>h
" imap <s-j> <c-o><c-w>j
" imap <s-k> <c-o><c-w>k
" imap <s-l> <c-o><c-w>l

" Fast navigation
" ----------------------------------------------------
nnoremap m :MRU<CR>

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" ----------------------------------------------------
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endi

" Create/edit file in the current directory
" ----------------------------------------------------
nmap :ed :edit %:p:h/

" Tagbar
" ----------------------------------------------------
nmap <F2> :TagbarToggle<cr>

" vim-go
" ----------------------------------------------------
au FileType go nmap <leader>rt <Plug>(go-run-tab)
let g:go_term_enabled = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


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

" vim: ft=vim
