" ----------------------------------------------------
" file:     $HOME/dotfiles/vim/startup/functions.vim
" author    jls - http://sjorssparreboom.nl
" vim:nu:ai:si:et:ts=4:sw=4:fdm=indent:fdn=1:ft=conf:
" ----------------------------------------------------

" {{{ toggle colored right border after 80 chars
set colorcolumn=0
let s:color_column_old = 80

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction
nnoremap <bar> :call <SID>ToggleColorColumn()<cr>
" }}}

" {{{ Map keys to toggle functions
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" }}}

" {{{
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}

nnoremap <C-n> :call NumberToggle()<cr>

" {{{ Let me Count words
let g:word_count=" "
function WordCount()
    return g:word_count
endfunction
function UpdateWordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000
augroup WordCounter
    au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
" }}}

" {{{ let me create a directory and file in one go
function s:MKDir(...)
    if         !a:0 
                \|| stridx('`+', a:1[0])!=-1
                \|| a:1=~#'\v\\@<![ *?[%#]'
                \|| isdirectory(a:1)
                \|| filereadable(a:1)
                \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>
" }}}


" {{{ fix all the tab issues
if exists("+showtabline")
    function MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let s .= i . ')'
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let file = bufname(buflist[winnr - 1])
            let file = fnamemodify(file, ':p:t')
            if file == ''
                let file = '[No Name]'
            endif
            let s .= file
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
" }}}

" {{{ let me select the file from the buffer
function! BufSel(pattern)
    let bufcount = bufnr("$")
    let currbufnr = 1
    let nummatches = 0
    let firstmatchingbufnr = 0
    while currbufnr <= bufcount
        if(bufexists(currbufnr))
            let currbufname = bufname(currbufnr)
            if(match(currbufname, a:pattern) > -1)
                echo currbufnr . ": ". bufname(currbufnr)
                let nummatches += 1
                let firstmatchingbufnr = currbufnr
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(nummatches == 1)
        execute ":buffer ". firstmatchingbufnr
    elseif(nummatches > 1)
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            execute ":buffer ". desiredbufnr
        endif
    else
        echo "No matching buffers"
    endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
" }}}

" {{{ Strip the newline from the end of a string
function! Chomp(str)
    return substitute(a:str, '\n$', '', '')
endfunction
" }}}

" {{{ Find a file and pass it to cmd
function! DmenuOpen(cmd)
    let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
    if empty(fname)
        return
    endif
    execute a:cmd . " " . fname
endfunction
" }}}

" {{{ Custom tabline
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
    let s = ''
    " loop through each tab page
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#' " WildMenu
        else
            let s .= '%#Title#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T '
        " set page number string
        let s .= i + 1 . ''
        " get buffer names and statuses
        let n = ''  " temp str for buf names
        let m = 0   " &modified counter
        let buflist = tabpagebuflist(i + 1)
        " loop through each buffer in a tab
        for b in buflist
            if getbufvar(b, "&buftype") == 'help'
                " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
            elseif getbufvar(b, "&buftype") == 'quickfix'
                " let n .= '[Q]'
            elseif getbufvar(b, "&modifiable")
                let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
            endif
            if getbufvar(b, "&modified")
                let m += 1
            endif
        endfor
        " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
        let n = substitute(n, ', $', '', '')
        " add modified label
        if m > 0
            let s .= '+'
            " let s .= '[' . m . '+]'
        endif
        if i + 1 == tabpagenr()
            let s .= ' %#TabLineSel#'
        else
            let s .= ' %#TabLine#'
        endif
        " add buffer names
        if n == ''
            let s.= '[New]'
        else
            let s .= n
        endif
        " switch to no underlining and add final space
        let s .= ' '
    endfor
    let s .= '%#TabLineFill#%T'
    " right-aligned close button
    " if tabpagenr('$') > 1
    "   let s .= '%=%#TabLineFill#%999Xclose'
    " endif
    return s
endfunction
" }}}

" {{{
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction
" }}}

" {{{
" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction
" }}}

" Add all the comments here
let s:comment_map = {
    \  "c":             '\/\/',
    \  "cpp":           '\/\/',
    \  "go":            '\/\/',
    \  "java":          '\/\/',
    \  "javascript":     '\/\/',
    \  "scala":         '\/\/',
    \  "php":           '\/\/',
    \  "python":        '#',
    \  "eruby":         '<%#',
    \  "ruby":          '#',
    \  "sh":            '#',
    \  "desktop":       '#',
    \  "fstab":         '#',
    \  "conf":          '#',
    \  "unix":          '#',
    \  "profile":       '#',
    \  "bashrc":        '#',
    \  "bash_profile":  '#',
    \  "mail":          '>',
    \  "eml":           '>',
    \  "bat":           'REM',
    \  "ahk":           ';',
    \  "vim":           '"',
    \  "tex":           '%',
    \  "haskell":       '--',
    \}

" {{{
function! ToggleComment()
  if has_key(s:comment_map, &filetype)
    let comment_leader = s:comment_map[&filetype]
    if getline('.') =~ "^\\s*" . comment_leader . " " 
      " Uncomment the line
      execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
    else 
      if getline('.') =~ "^\\s*" . comment_leader
        " Uncomment the line
        execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
      else
        " Comment the line
        execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
      end
    end
  else
    echo "No comment leader found for filetype"
  end
endfunction

nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>
" }}}


" {{{
function! ModuleSection(...)
    let s:width = 80
    let comment_leader = s:comment_map[&filetype]
    let comment_leader = substitute(comment_leader, '\\', '', 'g')

    let name = 0 < a:0 ? a:1 : inputdialog("Section name: ")

    return comment_leader
    \       . repeat('-', s:width) . "\n"
    \       . comment_leader . " " . name . "\n"
    \       . "\n"

endfunction

nmap <silent> --s "=ModuleSection()<CR>gp
" }}}

" {{{

function! ModuleHeader(...)
    let s:width = 80
    let comment_leader = s:comment_map[&filetype]
    let comment_leader = substitute(comment_leader, '\\', '', 'g')

    let name = 0 < a:0 ? a:1 : inputdialog("Module: ")
    let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
    let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
    
    return comment_leader
    \       . repeat('-', s:width) 
    \       . "\n" 
    \       . comment_leader . " | \n" 
    \       . comment_leader . " Module      : " . name . "\n"
    \       . comment_leader . " Note        : " . note . "\n"
    \       . comment_leader . " \n"
    \       . comment_leader . " " . description . "\n"
    \       . comment_leader . " \n"
    \       . comment_leader . repeat('-', s:width) . "\n"
    \       . "\n"

endfunction

nmap <silent> --h "=moduleheader()<cr>:0put =<cr>
" }}}

" vim:ft=vim
