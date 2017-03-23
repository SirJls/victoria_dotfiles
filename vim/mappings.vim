" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/mappings.vim
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
nnoremap <F4> :buffers<CR>:buffer<Space>
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap

" expansions
" ----------------------------------------------------
inoremap ,% <%%><esc>F%i<space><space><esc>i
inoremap ,= <%=%><esc>F%i<space><space><esc>i

" OmniSharp
" ----------------------------------------------------
" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

nnoremap <leader>th :OmniSharpHighlightTypes<cr>

" Custom file navigation
" ----------------------------------------------------
nnoremap <leader>f :Files<cr>
nnoremap <leader>r :Find<cr>
