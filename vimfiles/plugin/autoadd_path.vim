" Vim global plugin for autoadding path.
" Last Change: 2019-07-31 08:24:39
" Maintainer: VimIcewind <VimIcewind@gmail.com>
" Revision: 0.1

if exists("loaded_autoadd_path")
    finish
endif
let loaded_autoadd_path = 1

" requirements, you must have these enabled or this is useless.
if(  !has('cscope') || !has('modify_fname') )
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

"==
" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function s:windowdir()
    if winbufnr(0) == -1
        let unislash = getcwd()
    else
        let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
    endif
    return tr(unislash, '\', '/')
endfunc
"
"==
" Find_in_parent
" find the file argument and returns the path to it.
" Starting with the current working dir, it walks up the parent folders
" until it finds the file, or it hits the stop dir.
" If it doesn't find it, it returns "Nothing"
function s:Find_in_parent(fln,flsrt,flstp)
    let here = a:flsrt
    while ( strlen( here) > 0 )
        if isdirectory( here . "/" . a:fln )
            return here
        endif
        let fr = match(here, "/[^/]*$")
        if fr == -1
            break
        endif
        let here = strpart(here, 0, fr)
        if here == a:flstp
            break
        endif
    endwhile
    return "Nothing"
endfunc
"
"==
" Cycle_addpath
"  cycle the add path.
function s:Cycle_addpath()
    if exists("b:gitpath")
        if stridx(&path, b:gitpath) == 0
            return
            "it is already added. don't try to readd it.
        endif
    endif
    let projpath = s:Find_in_parent(".git",s:windowdir(),$HOME)
    " echo "Found .git at: " . projpath
    " echo "Windowdir: " . s:windowdir()
    if projpath != "Nothing"
        if stridx(projpath,":") == -1
            let b:gitpath = projpath .'/**'
        else
            let b:gitpath = tr(projpath, '/', '\') . '\**'
        endif
        if stridx(&path, b:gitpath) == -1
            let &path = b:gitpath . "," . &path
        endif
    endif
endfunc

augroup autoadd_path
    au!
    au BufEnter * call <SID>Cycle_addpath()
augroup END

let &cpo = s:save_cpo
