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

" pop open spell suggestion menu
" ----------------------------------------------------
nnoremap <C-c> z=

" Navigation up or down is really up or down
" ----------------------------------------------------
nnoremap j gj
nnoremap k gk

" Quick Pairs
" ----------------------------------------------------
imap '' ''<ESC>i
imap "" ""<ESC>i
imap ( ()<ESC>i
imap [ []<ESC>i
imap { {}<ESC>i

" Insert current date and time
" ----------------------------------------------------
nnoremap <leader>d "=strftime("%d %b, %Y %X")<CR>p
nnoremap <leader>D "=strftime("%d %b, %Y %X")<CR>P

" Change to current directory
" ----------------------------------------------------
nnoremap cd :cd %:p:h<CR>:pwd<CR>

" Let me ESCAPE!
" ----------------------------------------------------
inoremap <leader><leader> \

" Allow all window commands in insert mode
" ----------------------------------------------------
imap <C-w> <C-o><C-w>

" Map for save & quit operations
" ----------------------------------------------------
nnoremap gq :q!<CR>
nnoremap gw :w!<CR>

" Map sort function to a key
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
nnoremap gv :vsplit<CR>
nnoremap gh :split<CR>

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
" nnoremap ; :

" Run PHPUnits tests
" ----------------------------------------------------
map <leader>t :!phpunit %<CR>

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
set wildignore+=*/public/forum/**

" Abbreviations
" ----------------------------------------------------
abbrev pft PHPUnit_Framework_TestCase

abbrev gm !php artisan make:model
abbrev gc !php artisan make:controller
abbrev gmig !php artisan make:migration

" Edit todo list for project
" ----------------------------------------------------
nmap todo :e todo.txt<CR>

" Auto-remove trailing spaces
" ----------------------------------------------------
autocmd BufWritePre *.php :%s/\s\+$//e

" Laravel framework commons
" ----------------------------------------------------
nmap <leader>lr  :e app/Http/routes.php<cr>
nmap <leader>lca :e config/app.php<cr>81Gf(%O
nmap <leader>lcd :e config/database.php<cr>
nmap <leader>lc :e composer.json<cr>

" Homestead
" ----------------------------------------------------
nmap <leader>hs :e /home/jls/.homestead/Homestead.yaml

" Concept - load underlying class for Laravel
" ----------------------------------------------------
nmap lf :call FacadeLookup()<cr>

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
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap

" vim: ft=vim
