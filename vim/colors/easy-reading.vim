set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "easy-reading"

if &t_Co > 2 || has('gui_running')
  syntax on
endif

" General colors                                                            {{{
hi Normal       cterm=None    ctermfg=None ctermbg=None gui=None    guifg=#a8b6b8 guibg=#1c1c1c
hi Visual                                  ctermbg=238                            guibg=#444444
hi Search                                  ctermfg=238                            guibg=#444444
hi StatusLine                 ctermfg=236  ctermbg=242              guifg=#303030 guibg=#666666
hi WildMenu     cterm=bold    ctermfg=255  ctermbg=23   gui=bold    guifg=#eeeeee guibg=#005f5f
hi ColorColumn                             ctermbg=233                            guibg=#121212
hi LineNr       cterm=bold    ctermfg=242  ctermbg=236  gui=bold    guifg=#666666 guibg=#303030
hi CursorColumn                            ctermbg=None                           guibg=#1c1c1c
hi CursorLineNr cterm=bold    ctermfg=248  ctermbg=238  gui=bold    guifg=#a8a8a8 guibg=#444444
hi SignColumn                              ctermbg=236                            guibg=#303030
hi Folded       cterm=bold    ctermfg=74   ctermbg=236  gui=bold    guifg=#5fafd7 guibg=#303030
hi FoldColumn   cterm=bold    ctermfg=74   ctermbg=236  gui=bold    guifg=#5fafd7 guibg=#303030
hi VertSplit    cterm=None    ctermfg=251  ctermbg=251  gui=None    guifg=#c6c6c6 guibg=#c6c6c6
hi Error        cterm=reverse ctermfg=167  ctermbg=238  gui=reverse guifg=#d75f5f guibg=#444444
hi ErrorMsg     cterm=bold    ctermfg=167  ctermbg=None gui=bold    guifg=#d75f5f guibg=#1c1c1c
hi NonText                    ctermfg=30                            guifg=#008787
hi SpecialKey                 ctermfg=238                           guifg=#444444

" Tabline
hi TabLineFill                ctermfg=None  ctermbg=None            guifg=#1c1c1c guibg=#1c1c1c
hi Tabline                    ctermfg=None  ctermbg=None gui=None   guifg=#a8b6b8 guibg=#1c1c1c
hi TabLineSel                 ctermfg=None  ctermbg=None gui=italic guifg=#ffd7ff guibg=#1c1c1c

"                                                                           }}}
" Vim => 7.0 specific colors                                                {{{
if version >= 700
  hi CursorLine cterm=None  ctermfg=None ctermbg=235 gui=None               guibg=#262626
  hi MatchParen cterm=None  ctermfg=None ctermbg=239 gui=None               guibg=#4e4e4e
  hi Pmenu                  ctermfg=238  ctermbg=250          guifg=#444444 guibg=#bcbcbc
  hi PmenuSel               ctermfg=238  ctermbg=39           guifg=#444444 guibg=#00afff
endif
"                                                                           }}}
" Syntax highlighting                                                       {{{
hi Comment   cterm=None ctermfg=243              gui=None guifg=#767676
hi Statement            ctermfg=3   ctermbg=None          guifg=#aeae86
"                                                                           }}}
" Diff highlighting                                                         {{{
hi DiffAdd    cterm=reverse ctermfg=81  ctermbg=238 gui=reverse guifg=#5fd7ff guibg=#444444
hi DiffChange cterm=reverse ctermfg=225 ctermbg=238 gui=reverse guifg=#ffd7ff guibg=#444444
hi DiffDelete cterm=reverse ctermfg=159 ctermbg=238 gui=reverse guifg=#afffff guibg=#444444
hi DiffText   cterm=reverse ctermfg=211 ctermbg=238 gui=reverse guifg=#ff8faf guibg=#444444
"                                                                           }}}
" Spelling                                                                  {{{
if has("spell")
  hi SpellBad   cterm=reverse ctermfg=224 ctermbg=238 gui=reverse guifg=#ffd7d7 guibg=#444444
  hi SpellCap   cterm=reverse ctermfg=81  ctermbg=238 gui=reverse guifg=#5fd7ff guibg=#444444
  hi SpellLocal cterm=reverse ctermfg=116 ctermbg=238 gui=reverse guifg=#87d7d7 guibg=#444444
  hi SpellRare  cterm=reverse ctermfg=225 ctermbg=238 gui=reverse guifg=#ffd7ff guibg=#444444
endif
