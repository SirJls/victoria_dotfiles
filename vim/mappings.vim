" -- Meta ---------------------------------------------------------------------
" -- File:   ${DOTFILES}/vim/mappings.vim
" -- Author: SirJls - http://sjorssparreboom.nl
" -----------------------------------------------------------------------------

" -- Mappings -----------------------------------------------------------------

no / /\v

cmap w!! w !sudo tee % > /dev/null
noremap <silent> <Space> :silent noh<Bar>echo<CR>

vnoremap < <gv
vnoremap > >gv

nnoremap <leader>f :Files<cr>
nnoremap <leader>r :Find<cr>

inoremap ,% <%%><esc>F%i<space><space><esc>i
inoremap ,= <%=%><esc>F%i<space><space><esc>i

nnoremap <Leader>[ :lprev<CR>
nnoremap <Leader>] :lnext<CR>

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" nnoremap <F4> :buffers<CR>:buffer<Space>
MapToggle <F4> wrap
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch

" vim:set ft=vim et sw=2 ts=2 tw=79:
