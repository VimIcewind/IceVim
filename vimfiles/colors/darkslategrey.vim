" Vim color file
" Maintainer:   jiqing(jiqingwu@gmail.com)
" Create: 2011-04-11
" Last Change: 2011-04-11

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="darkslategrey"

""""""""""""""""""""""""""""""""""""""
" for gvim
""""""""""""""""""""""""""""""""""""""

hi Normal guifg=#f6d149 guibg=#133333
hi IncSearch guifg=hotpink guibg=mediumblue 
hi Search guibg=#84b7fa guifg=black
hi Visual guibg=black guifg=#5bb80a
hi Cursor guibg=#c760f4
hi CursorLine guibg=#041919
hi Folded guifg=#71cf71 guibg=#203f3f  
"hi FoldColumn 

hi Title guifg=gold gui=bold
hi Question guifg=#14ff43 gui=italic
hi SpecialKey guifg=#ed414d
"hi NonText  guibg=gray45

hi ErrorMsg guibg=black guifg=red
hi WarningMsg guifg=OrangeRed
hi ModeMsg guifg=gold
hi MoreMsg guifg=lightblue
hi VimError guifg=DeepPink3 gui=bold

hi LineNr guifg=lightgrey guibg=#202a2a
hi VertSplit guibg=lightyellow guifg=darkgrey
hi StatusLine guifg=black guibg=#bfbfbf gui=bold
hi StatusLineNC guifg=dimgray guibg=#bfbfbf
hi TabLine  guibg=#096e6e guifg=#e6c689
hi TabLineSel  guibg=#133333 guifg=gold
hi WildMenu guifg=black guibg=#29b9e9
"for complete menu
hi Pmenu guifg=black guibg=#29b9e9
"hi Scrollbar 
"hi Tooltip  

" syntax highlighting groups
hi Constant guifg=#eee51d
hi String guifg=coral
hi Number   guifg=#f28180
hi Float   guifg=#f6a1cd
hi Boolean  guifg=#92d0f6
hi Operator guifg=#f4e360

hi Identifier guifg=#b4c1f9 
hi Function guifg=skyblue gui=bold
hi Statement guifg=#f6fe87
hi PreProc guifg=orange
hi Type  guifg=palegreen gui=italic
hi Comment guifg=#05afaf

hi Special guifg=#fc80b7 gui=bold
hi Underlined gui=underline
hi Ignore guifg=gray45
hi Error guibg=black guifg=red
hi Todo  guibg=tan guifg=black       gui=NONE

"""""""""""""""""""""""""""""""""
" for vim on colorful terminal
"""""""""""""""""""""""""""""""""
hi SpecialKey ctermfg=1
"hi NonText cterm=bold ctermfg=darkblue
hi Directory ctermfg=14
hi ErrorMsg cterm=bold ctermfg=7 ctermbg=1
hi IncSearch cterm=NONE ctermfg=15 ctermbg=12
hi Search cterm=NONE ctermfg=12 ctermbg=10
hi MoreMsg ctermfg=2
hi ModeMsg cterm=NONE ctermfg=5
hi LineNr ctermfg=3
hi Question ctermfg=12 cterm=italic
hi StatusLine cterm=bold ctermfg=15 ctermbg=2
hi StatusLineNC cterm=reverse
hi VertSplit ctermbg=darkgrey ctermfg=lightgrey
hi Title ctermfg=5 cterm=bold
hi Visual cterm=reverse
hi VisualNOS cterm=bold,underline
hi WarningMsg ctermfg=1
hi WildMenu ctermfg=0 ctermbg=3
hi Folded ctermfg=darkgrey ctermbg=NONE
hi FoldColumn ctermfg=darkgrey ctermbg=NONE
hi DiffAdd ctermbg=4
hi DiffChange ctermbg=5
hi DiffDelete cterm=bold ctermfg=4 ctermbg=6
hi DiffText cterm=bold ctermbg=1
hi Comment ctermfg=6
hi Constant ctermfg=3
hi Special ctermfg=5 cterm=bold
hi Identifier ctermfg=6
hi Statement ctermfg=3
hi PreProc ctermfg=5
hi Type  ctermfg=2
hi Underlined cterm=underline ctermfg=5
hi Ignore ctermfg=8 cterm=italic
hi Error cterm=bold ctermfg=7 ctermbg=1
hi TabLine  ctermbg=8 ctermfg=7
hi CursorLine ctermbg=lightgray
