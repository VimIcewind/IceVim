"Last Modified: 2019-12-24 14:03:30

"当由Vim修改本文件保存时，自动更新本文件的修改日期
au BufWritePre .vimrc norm mVMmmggf2C=strftime("%Y-%m-%d %H:%M:%S")'m`V
"Notice:  is <C-V><C-R>   is <C-V><C-M>   is <C-V><C-[> when input this command into this file.
"Notice:  is <C-R>   is <C-M>   is <C-[> when you type this command by hand.

"不使用vi兼容模式
set nocompatible

"返回系统类型 eg: Windows, Linux, Mac...
func! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "Windows"
    elseif has("unix")
        return "Linux"
    endif
endfunc

if has("gui_running")
    "设置GUI窗口位置
    if MySys() == "Windows"
        "1366x768
        winpos 354 120
        "1440x900
        "winpos 392 180
        "1920x1080
        "winpos 630 280
    elseif MySys() == "Linux"
        winpos 360 150
        "winpos 636 280
    endif
    "设置GUI窗口的大小
    set lines=25
    set columns=80
    "设置菜单语言为默认的English
    set langmenu=none
    "调整窗口大小
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=t " 隐藏菜单栏中的撕下此菜单
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set showtabline=0 " 隐藏Tab栏
    ""字体相关设置
    if MySys() == "Linux"
        "显示的字体
        set guifont=Monospace\ 10
        "set guifont=Nimbus\ Mono\ L\ 10
    elseif MySys() == "Windows"
        "显示的字体
        "set guifont=Consolas:h11:cANSI
        set guifont=Consolas\ for\ Powerline\ FixedD:h11
    endif
    "设置默认的当前目录为用户家目录
    cd ~
endif

"窗口最大化
"if has("win32")
"    au GUIEnter * simalt ~x
"else
"    au GUIEnter * call MaximizeWindow()
"endif
"
"function! MaximizeWindow()
"    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
"endfunction

"自动切换当前目录为当前文件所在的目录
if exists("+autochdir")
    set autochdir
endif

""文件相关设置
"侦测文件类型
filetype on
"载入文件类型插件
filetype plugin on
"为特定文件类型载入相关缩进文件
filetype indent on

"Vim内部使用的编码
set enc=utf-8
"文件编码设置fileencoding
set fenc=utf-8
"文件默认换行符为unix的\n即<LF>
set fileformat=unix
"如果Linux系统编码包含GB(GBK,gbk,GB2312,gb2312,GB18030,gb18030), 则Vim内部编码cp936, 文件编码默认cp936
if MySys() == "Linux" && match(toupper(system("echo $LANG")), "GB") > 0
    "Vim内部使用的编码
    set enc=cp936
    "文件编码设置fileencoding
    set fenc=cp936
endif

"把所有不明宽度的字符的宽度置为双倍字符宽度
set ambiwidth=double
"Vim自动探测fileencoding的顺序列表
set fencs=ucs-bom,utf-8,gbk,cp936,gb2312,gb18030,big5,euc-jp,euc-kr,latin1
"解决菜单乱码
"source $VIMRUNTIME/menu.vim
"source $VIMRUNTIME/delmenu.vim
"解决消息乱码
"language mes zh_CN.utf-8

""Quickfix设置
"Quickfix messages编码转换
function! QfMakeConv()
    let qflist = getqflist()
    for i in qflist
        let i.text = iconv(i.text, "cp936", "utf-8")
    endfor
    call setqflist(qflist)
endfunction
if MySys() == "Windows"
    au QuickfixCmdPost make call QfMakeConv()
endif
"没有错误和警告时，QuickFix窗口自动关闭
au QuickfixCmdPost make call QfAutoDisplay()
function! QfAutoDisplay()
    if getqflist() == []
        cclose
    else
        copen 10
    endif
endfunction
" QuickFixExitOnlyWindow when QuickFix window is lonely present.
"au BufEnter [Quickfix List] call QfExitOnlyWindow()
"function! QfExitOnlyWindow()
"    " Before quitting Vim, delete the QuickFix buffer so that
"    " the '0 mark is correctly set to the previous buffer.
"    if &buftype == "quickfix"
"        if winbufnr(2) == -1
"            if tabpagenr('$') == 1
"                " Only one Quickfix page is present
"                bdelete
"                quit
"            else
"                " More than one tab page is present. Close only the current tab page
"                close
"            endif
"        endif
"    endif
"endfunction

"设置w可以包含的字符
"set iskeyword=@,48-57,_,.
"编辑一个文件时，直接用相应类型的iskeyword
if has("autocmd")
    "autocmd FileType c,cpp set iskeyword=@,48-57,_,.,-,>
    autocmd FileType c,cpp set iskeyword=@,48-57,_
endif

"历史记录数
set history=1000
"覆盖文件时不备份文件
set nobackup
"在处理未保存或只读文件的时候，弹出确认
set confirm

""显示相关设置
"显示状态栏 (默认值为 1, 单个文件无法显示状态栏)
set laststatus=2
" 增强模式中的命令行自动完成操作
set wildmenu
"显示未完成的命令
set showcmd
"在编辑过程中，在右下角显示光标位置的状态行
"set ruler
"由于使用了airline插件，故不在底行显示当前所处的模式
set noshowmode
"光标所在的行出现一条淡色的线，更容易找到光标的所在位置
"set cursorline

"语法高亮
syntax enable
syntax on

"高亮显示搜索结果
set hlsearch
"对输入要搜索的文字实时匹配
set incsearch

"允许backspace和光标键跨越行边界
set backspace=indent,eol,start
set whichwrap+=<,>,[,],h,l

"继承前一行的缩进方式，特别适用于多行注释
set autoindent
"粘贴时不自动添加缩进
"set paste
"开启C语言缩进
set cindent
"开启新行时使用智能自动缩进
set smartindent
"自动匹配( )、[ ]、{ }，时间0.2秒
set showmatch
set matchtime=2
"设置光标超过 78 列的时候折行
"set textwidth=78
"防止特殊符号无法正常显示
set ambiwidth=double
"显示最多行，不显示多行的@
set display=lastline

"分割窗口时保持相等的宽/高
set equalalways
if has("autocmd")
    autocmd VimResized * normal =
endif

"设置折叠
if has("syntax")
    "默认不折叠
    set foldenable!
    "用缩进来定义折叠
    set foldmethod=indent
    "设定折叠的最大嵌套层数为1，仅用于"indent"和"syntax"折叠
    set foldnestmax=1
    "设置为在折叠上水平移动时打开折叠
    set foldopen=hor
    "设置为自动关闭折叠
    "set foldclose=all
endif

"让TOhtml产生有CSS语法的html
let html_use_css=1

"编辑一个文件时，直接用相应的折叠风格
if has("autocmd")
    autocmd FileType htm,html,xhtml,xml,jsp set foldnestmax=16
endif

""设置缩进和Tab
set sw=8 sts=8 ts=8 smarttab
set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
"编辑一个文件时，直接用相应的缩进风格
if has("autocmd")
    autocmd FileType c,cpp,go,make set sw=8 sts=8 ts=8 smarttab
    autocmd FileType java,groovy,ant set sw=4 sts=4 ts=4 expandtab
    autocmd FileType sh,python,perl,ruby,php set sw=4 sts=4 ts=4 expandtab
    autocmd FileType htm,html,xhtml,xml,jsp set sw=4 sts=4 ts=4 expandtab
    autocmd FileType typescript,javascript,json,vue set sw=4 sts=4 ts=4 expandtab
    autocmd FileType vim,tex,latex,sql set sw=4 sts=4 ts=8 expandtab
    autocmd FileType lisp set sw=2 sts=2 ts=2 expandtab
endif

"Longline Linux 风格缩进
func! LL()
    "设定缩进时的宽度为8
    set shiftwidth=8
    "使得按退格键时可以一次删掉8个空格
    set softtabstop=8
    "设定tab长度为8
    set tabstop=8
    "不将tab用空格替换
    set noexpandtab
    "将空格用tab替换
    set smarttab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!indent\ -linux\ -l256"
    "用g/indent.*\_s$/norm 2dd去掉indent的Warning
    exec "g\/indent\.\*\\_s\$\/norm 2dd"
    exec "normal G"
endfunc
"Linux 风格缩进
func! LT()
    "设定缩进时的宽度为8
    set shiftwidth=8
    "使得按退格键时可以一次删掉8个空格
    set softtabstop=8
    "设定tab长度为8
    set tabstop=8
    "不将tab用空格替换
    set noexpandtab
    "将空格用tab替换
    set smarttab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!indent\ -linux"
    "exec "%!astyle\ --style=linux"
    "exec "%!astyle\ -A8"
    exec "normal G"
endfunc
"K&R 风格缩进
func! KR()
    "设定缩进时的宽度为4
    set shiftwidth=4
    "使得按退格键时可以一次删掉4个空格
    set softtabstop=4
    "设定tab长度为8
    set tabstop=8
    "将tab用空格替换
    set expandtab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L2,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!indent\ -kr -nut"
    "exec "%!astyle\ --style=kr"
    "exec "%!astyle\ -A3"
    exec "normal G"
endfunc
"MS 风格缩进
func! MS()
    "设定缩进时的宽度为4
    set shiftwidth=4
    "使得按退格键时可以一次删掉4个空格
    set softtabstop=4
    "设定tab长度为8
    set tabstop=8
    "将tab用空格替换
    set expandtab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L2,:s,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!indent\ -kr\ -bl\ -bli0\ -cli4 -nut"
    exec "normal G"
endfunc
"GNU 风格缩进
func! GNU()
    "设定缩进时的宽度为2
    set shiftwidth=2
    "使得按退格键时可以一次删掉2个空格
    set softtabstop=2
    "设定tab长度为8
    set tabstop=8
    "将tab用空格替换
    set expandtab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{s,}0,^0,:0,L-1,=s,l0,b0,gs,hs,p5,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!indent"
    "exec "%!astyle\ --style=gnu"
    "exec "%!astyle\ -A7"
    exec "normal G"
endfunc
"go gofmt 风格缩进
func! GO()
    "设定缩进时的宽度为8
    set shiftwidth=8
    "使得按退格键时可以一次删掉8个空格
    set softtabstop=8
    "设定tab长度为8
    set tabstop=8
    "不将tab用空格替换
    set noexpandtab
    "将空格用tab替换
    set smarttab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码
    exec "normal =G"
    exec "%!gofmt"
    exec "normal G"
endfunc
"Java Eclipse风格缩进
func! JE()
    "设定缩进时的宽度为4
    set shiftwidth=4
    "使得按退格键时可以一次删掉4个空格
    set softtabstop=4
    "设定tab长度为4
    set tabstop=4
    "将tab用空格替换
    set expandtab
    "将空格用tab替换
    set nosmarttab
    "设定 Vim 来如何进行缩进
    set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:0,=s,l0,b0,gs,hs,p0,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j1,J1,)20,*70,#0
    "格式化代码 用4个空格缩进
    exec "normal =G"
    exec "%!astyle\ -A2 -I -U -Y -L -p -H -k3 -q -z2"
    "格式化代码 用tab缩进
    "exec "%!astyle\ -A2 -I -U -Y -T4 -L -p -H -k3 -q -z2"
    exec "normal G"
endfunc
"DS 去行尾空格
func! DS()
    if search('\s\+$', 'pw') > 0
        "去掉行尾空格
        exec "%s/\\s\\+$//"
        exec "update"
    endif
endfunc
"TS 将Tab转换为8个空格
func! TS()
    if search('\t', 'pw') > 0
        "将Tab转换为8个空格
        exec "%s/\\t/        /g"
    endif
endfunc

""编译、调试、运行相关函数
"Debug 调试期版本
"编译c源文件
func! CompileC()
    exec "update"
    set makeprg=gcc\ -g\ -Wall\ -o\ %<\ %
    exec "make"
    set makeprg=make
endfunc

"编译cpp源文件
func! CompileCpp()
    exec "update"
    set makeprg=g++\ -g\ -Wall\ -o\ %<\ %
    exec "make"
    set makeprg=make
endfunc

"编译java源文件
func! CompileJava()
    exec "update"
    if search('^\s*package\s\+.*;$', 'pw') > 0
        set makeprg=javac\ -g\ -d\ ../..\ %
    else
        set makeprg=javac\ -g\ -d\ .\ %
    endif
    exec "make"
    set makeprg=make
endfunc

"编译C#源文件
func! CompileCS()
    exec "update"
    set makeprg=csc\ /nologo\ -debug\ %
    exec "make"
    set makeprg=make
endfunc

"编译scala源文件
func! CompileScala()
    exec "update"
    set makeprg=scalac\ %
    exec "make"
    set makeprg=make
endfunc

"编译go源文件
func! CompileGo()
    exec "update"
    set makeprg=go\ build\ %
    exec "make"
    set makeprg=make
endfunc

"编译rust源文件
func! CompileRust()
    exec "update"
    set makeprg=rustc\ %
    exec "make"
    set makeprg=make
endfunc

"编译typescript源文件
func! CompileTS()
    exec "update"
    set makeprg=tsc\ %
    exec "make"
    set makeprg=make
endfunc

"编译elisp源文件
func! CompileEL()
    exec "update"
    set makeprg=emacs\ -batch\ -f\ batch-byte-compile\ %
    exec "make"
    set makeprg=make
endfunc

"汇编、连接asm源文件
func! CompileAsm()
    if MySys() == "Windows"
        exec "update"
        set makeprg=nasm\ -f\ elf\ -g\ -F\ stabs\ -o\ %<.o\ %
        exec "make"
        if getqflist() == []
            set makeprg=ld\ -o\ %<.exe\ %<.o
            exec "make"
            set makeprg=make
        endif
    elseif MySys() == "Linux"
        exec "update"
        set makeprg=nasm\ -f\ elf\ -g\ -F\ stabs\ -o\ %<.o\ %
        exec "make"
        if getqflist() == []
            set makeprg=ld\ -o\ %<\ %<.o
            exec "make"
            set makeprg=make
        endif
    endif
endfunc

"编译makefile项目
func! CompileMake()
    exec "update"
    set makeprg=make
    exec "make\ -f\ %"
endfunc

"Release 最终的释放期版
"编译C源文件
func! ReleaseCompileC()
    exec "update"
    set makeprg=gcc\ -Wall\ -O2\ -o\ %<\ %
    exec "make"
    set makeprg=make
endfunc

"编译C++源文件
func! ReleaseCompileCpp()
    exec "update"
    set makeprg=g++\ -Wall\ -O2\ -o\ %<\ %
    exec "make"
    set makeprg=make
endfunc

"编译Java源文件
func! ReleaseCompileJava()
    exec "update"
    if search('^\s*package\s\+.*;$', 'pw') > 0
        set makeprg=javac\ -d\ ../..\ %
    else
        set makeprg=javac\ -d\ .\ %
    endif
    exec "make"
    set makeprg=make
endfunc

"编译ASM源文件
func! ReleaseCompileAsm()
    if MySys() == "Windows"
        exec "update"
        set makeprg=nasm\ -f\ elf\ -o\ %<.o\ %
        exec "make"
        if getqflist() == []
            set makeprg=ld\ -o\ %<.exe\ %<.o
            exec "make"
            set makeprg=make
        endif
    elseif MySys() == "Linux"
        exec "update"
        set makeprg=nasm\ -f\ elf\ -o\ %<.o\ %
        exec "make"
        if getqflist() == []
            set makeprg=ld\ -o\ %<\ %<.o
            exec "make"
            set makeprg=make
        endif
    endif
endfunc

"编译makefile项目
func! ReleaseCompileMake()
    exec "update"
    set makeprg=make
    exec "make\ -f\ %"
endfunc

"编译LaTeX源文件
func! CompileLaTeX()
    exec "update"
    let compilecmd="!latex"
    let compileflag=""
    exec compilecmd.compileflag." %"
    "exec "w"
    "set makeprg=latex\ %
    "exec "make"
endfunc

"运行c、cpp、asm程序
func! RunCCppAsm()
    if MySys() == "Windows"
        "exec "!.\\".expand("%<")
        "exec "!start .\\".expand("%<")
        exec "!start cmd /C \".\\".expand("%<")." && pause\""
    elseif MySys() == "Linux"
        exec "!./%<"
    endif
endfunc

"运行java类文件
func! RunJava()
    if MySys() == "Windows"
        if search('^\s*package\s\+.*;$', 'pw') > 0
            "exec "norm gg/package/s+8" | exec "!java " . expand('<cfile>') . ".%<"
            "exec "norm gg/package/s+8" | exec "!start java " . expand('<cfile>') . ".%<"
            "exec "norm gg/package/s+8" | exec "!start cmd /C \"java ".expand('<cfile>').".%<"." && pause\""
            exec "norm gg/package/s+8" | exec "!start cmd /C \"cd ../.. && java ".expand('<cfile>').".%<"." && pause\""
            exec "norm gg"
        else
            "exec "!java %<"
            "exec "!start java %<"
            "exec "!start cmd /K \"java %<\""
            exec "!start cmd /C \"java %< && pause\""
        endif
    elseif MySys() == "Linux"
        if search('^\s*package\s\+.*;$', 'pw') > 0
            "exec "norm gg/package/s+8" | exec "!java " . expand('<cfile>') . ".%<"
            exec "norm gg/package/s+8" | exec "!cd ../.. && java ".expand('<cfile>').".%<"
            exec "norm gg"
        else
            exec "!java %<"
        endif
    endif
endfunc

"运行C#类文件
func! RunCS()
    if MySys() == "Windows"
        exec "!start cmd /C \".\\".expand("%<")." && pause\""
    elseif MySys() == "Linux"
        exec "!%<"
    endif
endfunc

"运行java类文件
func! RunScala()
    if MySys() == "Windows"
        exec "!start cmd /C \"scala %< && pause\""
    elseif MySys() == "Linux"
        exec "!scala %<"
    endif
endfunc

"运行go源文件
func! RunGo()
    if MySys() == "Windows"
        "exec "!.\\".expand("%<")
        "exec "!start .\\".expand("%<")
        exec "!start cmd /C \".\\".expand("%<")." && pause\""
    elseif MySys() == "Linux"
        exec "!./%<"
    endif
endfunc

"运行rust源文件
func! RunRust()
    if MySys() == "Windows"
        "exec "!.\\".expand("%<")
        "exec "!start .\\".expand("%<")
        exec "!start cmd /C \".\\".expand("%<")." && pause\""
    elseif MySys() == "Linux"
        exec "!./%<"
    endif
endfunc

"运行perl源文件
func! RunPerl()
    exec "update"
    exec "!perl %"
endfunc

"运行python源文件
func! RunPython()
    exec "update"
    exec "!python %"
endfunc

"运行ruby源文件
func! RunRuby()
    exec "update"
    exec "!ruby %"
endfunc

"运行typescript源文件
func! RunTS()
    exec "update"
    exec "!node %<.js"
endfunc

"运行javascript源文件
func! RunJS()
    exec "update"
    exec "!node %"
endfunc

"运行elisp源文件
func! RunEL()
    exec "update"
    exec "!emacs --script %"
endfunc

"预览htm、html、xhtml结果
func! RunHtml()
    exec "update"
    if MySys() == "Windows"
        "exec "!start\ cmd\ /C\ \"%\""
        exec "!start\ cmd\ /C\ \"".iconv(expand("%"), "utf-8", "cp936")."\""
    elseif MySys() == "Linux"
        exec "!firefox %"
    endif
endfunc

"预览LaTex结果
func! RunLaTeX()
    if MySys() == "Windows"
        exec "!yap %<.dvi"
    elseif MySys() == "Linux"
        exec "!xdvi %<"
    endif
endfunc

"根据文件类型自动选择相应的编译函数
func! CompileCode()
    if MySys() == "Linux"
        hi Search term=reverse ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
    endif
    if &filetype == "c"
        exec "call CompileC()"
    elseif &filetype == "cpp"
        exec "call CompileCpp()"
    elseif &filetype == "asm"
        exec "call CompileAsm()"
    elseif &filetype == "java"
        exec "call CompileJava()"
    elseif &filetype == "cs"
        exec "call CompileCS()"
    elseif &filetype == "scala"
        exec "call CompileScala()"
    elseif &filetype == "go"
        exec "call CompileGo()"
    elseif &filetype == "rust"
        exec "call CompileRust()"
    elseif &filetype == "typescript"
        exec "call CompileTS()"
    elseif &filetype == "lisp"
        exec "call CompileEL()"
    elseif &filetype == "tex"
        exec "call CompileLaTeX()"
    elseif &filetype == "plaintex"
        exec "call CompileLaTeX()"
    elseif &filetype == "make"
        exec "call CompileMake()"
    elseif &filetype == "perl"
        exec "call RunPerl()"
    elseif &filetype == "python"
        exec "call RunPython()"
    elseif &filetype == "ruby"
        exec "call RunRuby()"
    endif
endfunc

"根据文件类型自动选择相应的编译函数
func! ReleaseCompileCode()
    if &filetype == "c"
        exec "call ReleaseCompileC()"
    elseif &filetype == "cpp"
        exec "call ReleaseCompileCpp()"
    elseif &filetype == "asm"
        exec "call ReleaseCompileAsm()"
    elseif &filetype == "java"
        exec "call ReleaseCompileJava()"
    elseif &filetype == "tex"
        exec "call TexToPdf()"
    elseif &filetype == "plaintex"
        exec "call TexToPdf()"
    elseif &filetype == "make"
        exec "call CompileMake()"
    elseif &filetype == "perl"
        exec "call RunPerl()"
    elseif &filetype == "python"
        exec "call RunPython()"
    elseif &filetype == "ruby"
        exec "call RunRuby()"
    endif
endfunc

func! DviToPdf()
    if MySys() == "Windows"
        exec "!dvipdfmx %<"
    elseif MySys() == "Linux"
        exec "!dvipdf %<.dvi"
    endif
endfun

func! TexToPdf()
    exec "w"
    exec "!pdflatex %"
endfun

"根据文件类型自动选择相应的调试器调试
func! DebugCode()
    if MySys() == "Windows"
        if &filetype == "c"
            exec "!start gdb %<"
        elseif &filetype == "cpp"
            exec "!start gdb %<"
        elseif &filetype == "asm"
            exec "!start gdb %<"
        elseif &filetype == "java"
            exec "!start jdb %<"
        elseif &filetype == "make"
            exec "normal gg/:<CR>:noh<CR>b"|exec "!start gdb " . expand('<cfile>')
        endif
    elseif MySys() == "Linux"
        if &filetype == "c"
            exec "!gdb %<"
        elseif &filetype == "cpp"
            exec "!gdb %<"
        elseif &filetype == "asm"
            exec "!gdb %<"
        elseif &filetype == "java"
            exec "!jdb %<"
        elseif &filetype == "make"
            exec "normal gg/:<CR>:noh<CR>b"|exec "!gdb " . expand('<cfile>')
        endif
    endif
endfunc

"运行可执行文件
func! RunResult()
    if &filetype == "c"
        exec "call RunCCppAsm()"
    elseif &filetype == "cpp"
        exec "call RunCCppAsm()"
    elseif &filetype == "asm"
        exec "call RunCCppAsm()"
    elseif &filetype == "java"
        exec "call RunJava()"
    elseif &filetype == "cs"
        exec "call RunCS()"
    elseif &filetype == "scala"
        exec "call RunScala()"
    elseif &filetype == "go"
        exec "call RunGo()"
    elseif &filetype == "rust"
        exec "call RunRust()"
    elseif &filetype == "typescript"
        exec "call RunTS()"
    elseif &filetype == "javascript"
        exec "call RunJS()"
    elseif &filetype == "lisp"
        exec "call RunEL()"
    elseif &filetype == "tex"
        exec "call RunLaTeX()"
    elseif &filetype == "plaintex"
        exec "call RunLaTeX()"
    elseif &filetype == "perl"
        exec "!perl %"
    elseif &filetype == "python"
        exec "!python %"
    elseif &filetype == "ruby"
        exec "!ruby %"
    elseif &filetype == "make"
        exec "normal gg/:<CR>:noh<CR>b"|exec '!' . expand('<cfile>')
    elseif &filetype == "html"
        exec "call RunHtml()"
    elseif &filetype == "xhtml"
        exec "call RunHtml()"
    elseif &filetype == "css"
        exec "call RunHtml()"
    endif
endfunc

if has("autocmd")
    autocmd BufEnter *.pc set filetype=esqlc
    autocmd BufReadPost,BufWritePost *.java call SetJavaRunType()
endif
func! SetJavaRunType()
    if search('^\s*package\s\+.*;$', 'pw') == 0
        ":command! -nargs=? Run :!java %< <args>
        :command! -nargs=? Run :exe "!start cmd /C \"java %< && pause\""
    else
        ":command! -nargs=? Run :exe "normal gg/package/s+8<CR>:noh<CR>"|:exe "!java ".expand('<cfile>').".%< <args>"
        :command! -nargs=? Run :exe "norm gg/package/s+8" |:exe "!start cmd /C \"cd .. && java ".expand('<cfile>').".%<"." <args>"." && pause\""
    endif
endfunc

""设置快捷键
"外观
if has("gui_running")
    "调整窗口大小
    if MySys() == "Windows"
        :command Long :set lines=36 columns=80 | winpos 353 35 | :normal =
        :command Short :set lines=25 columns=80 | winpos 353 120 | :normal =
        :command Middle :set lines=36 columns=115 | winpos 213 35 | :normal =
        ":command Long :set lines=36 columns=80 | winpos 630 164 | :normal =
        ":command Short :set lines=25 columns=80 | winpos 630 280 | :normal =
        ":command Middle :set lines=36 columns=115 | winpos 487 164 | :normal =
        :command Big :set lines=53 columns=237 | winpos 2 30 | :normal =
    elseif MySys() == "Linux"
        :command Long :set lines=40 columns=80 | winpos 360 35
        :command Short :set lines=25 columns=80 | winpos 360 150
        :command Middle :set lines=40 columns=115 | winpos 222 35
    endif
    "设置:L执行的命令
    :command L :Long
    "设置:S执行的命令
    :command S :Short
    "设置:M执行的命令
    :command M :Middle
    "设置:B执行的命令
    :command B :Big
    ""Windows外观相关设置
    if MySys() == "Windows"
        "Shift+F5,Shift+F6,Shift+F7,Shift+F8 透明-不透明
        map <S-F5> <Esc>:call libcallnr("vimtweak.dll", "SetAlpha", 120)<CR>:normal v:normal<ESC>
        map <S-F6> <Esc>:call libcallnr("vimtweak.dll", "SetAlpha", 180)<CR>:normal v:normal<ESC>
        map <S-F7> <Esc>:call libcallnr("vimtweak.dll", "SetAlpha", 220)<CR>:normal v:normal<ESC>
        map <S-F8> <Esc>:call libcallnr("vimtweak.dll", "SetAlpha", 255)<CR>:normal v:normal<ESC>
        imap <S-F5> <C-O>:call libcallnr("vimtweak.dll", "SetAlpha", 120)<CR>
        imap <S-F6> <C-O>:call libcallnr("vimtweak.dll", "SetAlpha", 180)<CR>
        imap <S-F7> <C-O>:call libcallnr("vimtweak.dll", "SetAlpha", 220)<CR>
        imap <S-F8> <C-O>:call libcallnr("vimtweak.dll", "SetAlpha", 255)<CR>
        ""TopMost Window:
        "<F9> Enable
        map <F9> <Esc>:call libcallnr("vimtweak.dll", "EnableTopMost", 1)<CR>:normal v:normal<ESC>
        imap <F9> <C-O>:call libcallnr("vimtweak.dll", "EnableTopMost", 1)<CR>
        "<F10> Disable
        map <F10> <Esc>:call libcallnr("vimtweak.dll", "EnableTopMost", 0)<CR>:normal v:normal<ESC>
        imap <F10> <C-O>:call libcallnr("vimtweak.dll", "EnableTopMost", 0)<CR>
        ""FullScreen
        "<F11> or <Alt + Enter> Enable Disable
        map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>:normal v:normal<ESC>
        imap <F11> <C-O>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
        map <A-Enter> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>:normal v:normal<ESC>
        imap <A-Enter> <C-O>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    endif
endif

""颜色主题适用于Windowns,Linux...
if exists("+syntax")
    if has("gui_running")
        "主题默认设置
        colorscheme torte
    else
        colorscheme desert
    endif
    "colorscheme default
    map <F5> <Esc>:colorscheme default<CR>v<Esc>
    imap <F5> <C-O>:colorscheme default<CR>
    "colorscheme peachpuff
    map <F6> <Esc>:colorscheme peachpuff<CR>v<Esc>
    imap <F6> <C-O>:colorscheme peachpuff<CR>
    "colorscheme desert
    map <F7> <Esc>:colorscheme darkslategrey<CR>v<Esc>
    imap <F7> <C-O>:colorscheme darkslategrey<CR>
    "colorscheme torte
    map <F8> <Esc>:colorscheme torte<CR>v<Esc>
    imap <F8> <C-O>:colorscheme torte<CR>
endif

"gh临时关闭高亮显示搜索结果
map gh :noh<CR>:normal v:normal<ESC>

"gy系统剪切板复制
map gy "+y
"gy复制一个单词(从光标所在字符开始)，可配合YouDao词典的剪切板监视功能查词
"map gy "+ye
"gY复制一个单词(到光标所在字符结束)，可配合YouDao词典的剪切板监视功能查词
"map gY my"+yb`y

"2格缩进
map g=2 :set sw=2 sts=2 ts=8 expandtab<CR>
"4格缩进
map g=4 :set sw=4 sts=4 ts=4 expandtab<CR>
"8格缩进
map g=8 :set sw=8 sts=8 ts=8 smarttab<CR>
"Linux缩进风格 g=l
map g=l :call LT()<CR>v<Esc>
"K&R缩进风格 g=k
map g=k :call KR()<CR>v<Esc>
"MS缩进风格 g=m
map g=m :call MS()<CR>v<Esc>
"go gofmt缩进风格 g=g
map g=g :call GO()<CR>v<Esc>
"Java Eclipse缩进风格 g=j
map g=j :call JE()<CR>v<Esc>
"DS去掉尾空 g=d
map g=d :call DS()<CR>v<Esc>
"TS将行首Tab转换为8个空格 g=s
map g=s :call TS()<CR>v<Esc>

"格式化代码 g==
map g== :call FF()<CR>v<Esc>
func! FF()
    if &filetype == "c"
        exec "call LL()"
    elseif &filetype == "cpp"
        exec "call LL()"
    elseif &filetype == "java"
        exec "call JE()"
    elseif &filetype == "go"
        exec "call GO()"
    endif
endfunc

func! MAP()
    " gc 保存、编译
    map gc :call CompileCode()<CR>
    " gr 保存、运行
    map gr :call RunResult()<CR>
    " gl 调试
    map gl :call DebugCode()<CR>
    " gw 光标wrap到第一个错误或警告
    map gw :cfirst<CR>
    " gp 光标跳到上一个错误或警告
    map gp :cprevious<CR>
    " gn 光标跳到下一个错误或警告
    map gn :cnext<CR>
    " gs 释放
    map gs :call ReleaseCompileCode()<CR>
endfunc

"编辑一个文件时，直接用相应的键盘映射
if has("autocmd")
    autocmd FileType c,cpp,java,cs,scala,go,rust,make call MAP()
    autocmd FileType python,perl,ruby,php,typescript,javascript call MAP()
    autocmd FileType htm,html,xhtml,xml call MAP()
    autocmd FileType vim,lisp,tex,latex call MAP()
endif

"vue
au BufNewFile,BufRead *.vue,*.wpy call s:setFiletype()
function! s:setFiletype()
    " enable JavaScript autocmds first
    " let &filetype = 'javascript'

    " then set filetype
    let &filetype = 'vue'
endfunction

"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nmap <leader>1 :set filetype=xhtml<CR>
nmap <leader>2 :set filetype=css<CR>
nmap <leader>3 :set filetype=javascript<CR>
nmap <leader>4 :set filetype=jsp<CR>
nmap <leader>5 :set filetype=php<CR>

"":TOhtml的衍生版, :TH, :TW
"修改默认的网页编码为UTF-8
:command! TH :normal zn:TOggjjj3f=lct"UTF-8grZZ
"将配色置为默认配色白色
:command! TW :color default |:color default |:TH

"将本文件同步到需要同步的文件夹里
:command! SC :w! ~/.vimrc |:update

"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
"nnoremap <C-H> <C-W>h
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-L> <C-W>l

"在插入模式下，输入Ctrl_L代替Delete
"inoremap <C-L> <Del>
"在插入模式下，模拟Emacs的<C-L>
inoremap <C-L> <C-O>zz

":命令模式下的一组tcsh风格的键
:cnoremap <C-A> <Home>
:cnoremap <C-E> <End>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <C-H> <Backspace>
:cnoremap <C-D> <Delete>

" Alt-Space is System menu
if has("gui")
    noremap <M-Space> :simalt ~<CR>
    inoremap <M-Space> <C-O>:simalt ~<CR>
    cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-Tab is Next Tab
noremap <C-Tab> gt
inoremap <C-Tab> <C-O>gt
cnoremap <C-Tab> <C-C>gt
onoremap <C-Tab> <C-C>gt

" CTRL-Shift-Tab is Previous Tab
noremap <C-S-Tab> gT
inoremap <C-S-Tab> <C-O>gT
cnoremap <C-S-Tab> <C-C>gT
onoremap <C-S-Tab> <C-C>gT

""目录设置
"set path=./**
"设置的头文件*.h所在目录
if MySys() == "Windows"
    "set path+=D:\MinGW\include,D:\MinGW\lib\gcc\mingw32\4.9.3\include,D:\MinGW\lib\gcc\mingw32\4.9.3\include\c++
    set path+=D:\MinGW64\include,D:\MinGW64\lib\gcc\x86_64-w64-mingw32\8.1.0\include,D:\MinGW64\lib\gcc\x86_64-w64-mingw32\8.1.0\include\ssp,D:\MinGW64\lib\gcc\x86_64-w64-mingw32\8.1.0\include\c++
    ""补全时不搜索included files
    set complete=.,w,b,u,t
elseif MySys() == "Linux"
    set path+=/usr/include/,/usr/include/c++/*/
endif

"当有多个同名函数时，需要选择
noremap <C-]> g<C-]>
"生成 tags命令: ctags -R --langmap=c:.c.pc .
"在当前目录找不到tags文件时请到上层目录查找
"set tags=tags;/,.tags;/,TAGS;/,.TAGS;/
set tags=tags;/,.tags;/
"如果觉得到处放置tags文件不好，可以设置tags目录
"if MySys() == "Windows"
"    set tags=$Vim\tags
"elseif MySys() == "Linux"
"    set tags=~/.tags/
"endif

"设置dictionary目录
if MySys() == "Windows"
    set dictionary=$Vim\dict\words
elseif MySys() == "Linux"
    set dictionary=/usr/share/dict/words
endif

""插件的设置
"---------- Taglist.vim [显示程序中的宏定义、变量、函数、类] ----------
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_WinWidth=34
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Enable_Fold_Column=0
let Tlist_Inc_Winwidth=0

"---------- WinManager.vim [窗口管理] ----------
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=34

"--------------------Cscope设置--------------------
"生成cscope.out命令: cscope -Rbkq
if has("cscope")
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    if filereadable("cscope.out")
        cs add cscope.out
        "不自动设置当前目录为文件所在目录
        set noautochdir
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

"--------------------Airline设置--------------------
set t_Co=256
set ttimeoutlen=50
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#whitespace#enabled=0
"let g:airline#extensions#whitespace#symbol='!'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"if has("gui_running") && &enc == 'utf-8' && &fenc == 'utf-8'
if &enc == 'utf-8' && &fenc == 'utf-8'
    let g:airline_left_sep = '⮀'
    let g:airline_left_alt_sep = '⮁'
    let g:airline_right_sep = '⮂'
    let g:airline_right_alt_sep = '⮃'
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
    let g:airline_symbols.whitespace = '☲'
else
    "let g:airline_symbols_ascii = 1
    let g:airline_left_sep = '>'
    let g:airline_left_alt_sep = '>'
    let g:airline_right_sep = '<'
    let g:airline_right_alt_sep = '<'
    let g:airline_symbols.branch = '|'
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = 'LN'
    let g:airline_symbols.whitespace = 'LN'
endif
let g:airline_detect_paste=0
let g:airline#extensions#default#section_truncate_width = {'b': 79, 'x': 60, 'y': 55, 'z': 45}
let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr} %1l%#__restore__#:%1v'
"let g:airline#extensions#tabline#enabled=1

"--------------------bufexplore设置--------------------
" 打开Buffer Explore
"map gb :BufExplorer<CR>
" gbp 前一个Buffer
"map gbp :bprevious<CR>
" gbn 后一个Buffer
"map gbn :bnext<CR>
"关闭缓冲区
nnoremap g. :bd!<CR>
" Buffers操作快捷方式,模仿Tab操作的gt，gT
nnoremap gb :bnext<CR>
nnoremap gB :bNext<CR>

"------------------NERD_commenter设置------------------
map <C-Q> <plug>NERDCommenterToggle

"------------------ZenCoding设置------------------
"<C-_>,
let g:user_zen_leader_key = '<C-_>'
"------------------Emmet设置------------------
"<C-_>,
let g:user_emmet_leader_key = '<C-_>'

"------------------web-indent设置------------------
"Disable Logging
let g:js_indent_log = 0

""插件的快捷键设置
map <F2> <Esc>:NERDTreeToggle<CR>
imap <F2> <C-O>NERDTreeToggle<CR>
map <F3> <Esc>:TlistToggle<CR>:set nu!<CR>
imap <F3> <C-O>:TlistToggle<CR>:set nu!<CR>
map <F4> <Esc>:WMToggle<CR>:set nu!<CR>
imap <F4> <C-O>:WMToggle<CR>:set nu!<CR>
