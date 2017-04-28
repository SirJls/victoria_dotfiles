" ----------------------------------------------------
" file:     ${DOTFILES}/vim/startup/mappings.vim
" author    jls - http://sjorssparreboom.nl
" ----------------------------------------------------

" default to very magic
" ----------------------------------------------------
no / /\v

" Allows writing to files with root priviledges
" ----------------------------------------------------
cmap w!! w !sudo tee % > /dev/null

" space bar un-highlights search
" ----------------------------------------------------
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Easier moving of code blocks (better indentation)
" ----------------------------------------------------
vnoremap < <gv
vnoremap > >gv

" keys & functions
" ----------------------------------------------------
command! -nargs=+ MapToggle call MapToggle(<f-args>)
" nnoremap <F4> :buffers<CR>:buffer<Space>
MapToggle <F4> wrap
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch

" expansions
" ----------------------------------------------------
inoremap ,% <%%><esc>F%i<space><space><esc>i
inoremap ,= <%=%><esc>F%i<space><space><esc>i

" Custom file navigation
" ----------------------------------------------------
nnoremap <leader>f :Files<cr>
nnoremap <leader>r :Find<cr>
