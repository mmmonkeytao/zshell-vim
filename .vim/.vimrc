" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal

" see :h vundle for more details or wiki for FAQ

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" basic settings
let mapleader=";"

"定义快捷键，指定光标到行首和行尾
"nmap lb 0
"nmap le $
" 将选中文本块复制到系统剪贴板
nmap <Leader>y "+y
" 将系统剪贴板内容粘贴到Vim
nmap <leader>p "+p	
nmap <Leader>q :q<CR>	" 关闭当前分割窗口
nmap <Leader>w :w<CR>	" 保存当前窗口内容
nmap <Leader>WQ :wa<CR>:q<CR>	" 保存所有窗口内容并退出
nmap <Leader>Q :qa!<CR>	" 不作保存，直接退出

nnoremap nw <C-W><C-W>	" 依次遍历子窗口
nnoremap <Leader>lw <C-W>l	" 跳转到右方窗口
nnoremap <Leader>hw <C-W>h	" 跳转到左方窗口
nnoremap <Leader>kw <C-W>k	" 跳转到上方窗口
nnoremap <Leader>jw <C-W>j	" 跳转到下方窗口

nmap <Leader>pa %	" 在结对符之间跳转

set incsearch	" 开启实时搜索功能
set ignorecase	" 搜索时大小写不敏感
set nocompatible	" 关闭兼容模式
set wildmenu	" 自身命令行模式智能补全

"颜色配置
set background=dark
"colorscheme solarized
colorscheme molokai
"colorscheme phd

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 禁止折行
set nowrap

syntax enable
syntax on
" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让vim把连续数量的空格视为一个制表符
set softtabstop=4
" 随vim自启动

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动vim时关闭折叠代码
set nofoldenable

" 设置快捷键实现一键编译及运行C++
nmap <Leader>m :wa<CR> :cd build/<CR>:!rm -rf main<CR> :!cmake CMakeLists.txt<CR>:make<CR><CR> :cw<CR> :cd ..<CR>
nmap <Leader>g :wa<CR>:cd build/<CR>:!rm -rf main<CR>:!cmake CMakeLists.txt<CR>:make<CR><CR>:cw<CR>:cd ..<CR>:!build/main<CR>
nmap <Leader>d :!perl %<CR>

Plugin 'git://github.com/yegappan/grep.git'
" 快捷键速记法：search in project
nnoremap <Leader>sp :Grep -ir<CR><CR><CR>
" 快捷键速记法：search in buffer
nnoremap <Leader>sb :GrepBuffer -ir<CR><CR>

" Easy manipulation of 'runtimepath', 'path', 'tags', etc
"Bundle 'pathogen.vim'
" install YouCompleteMe
Bundle 'Valloric/YouCompleteMe'
" 基于语义的代码导航
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
" 只能是＃include或已打开的文件
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>
" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=Cyan ctermbg=black guifg=#005f87 guibg=#eee8d5
" 选中项
highlight PmenuSel ctermfg=yellow ctermbg=Gray guifg=#afd700 guibg=#106900

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全         
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_use_ultisnips_completer = 1

"STL-improved: Improved C++ STL syntax highlighting
Bundle 'git://github.com/Mizuchi/STL-Syntax.git'
"
" set self input
"Bundle 'git://github.com/SirVer/ultisnips.git'
if has('python')
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'
    autocmd BufNewFile,BufRead *.snippets set filetype=snippets
    let g:UltiSnipsSnippetDirectories=["mysnippets"]
    let g:UltiSnipsExpandTrigger="<leader><tab>"
    let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
    let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
    autocmd Filetype python :UltiSnipsAddFiletypes python
    autocmd Filetype html :UltiSnipsAddFiletypes html
    autocmd Filetype c :UltiSnipsAddFiletypes c
    autocmd Filetype cpp :UltiSnipsAddFiletypes cpp
    autocmd Filetype markdown :UltiSnipsAddFiletypes markdown
    autocmd Filetype perl :UltiSnipsAddFiletypes perl
endif
" quickly make comments
Bundle 'The-NERD-Commenter'
" manage the file projects
Bundle 'The-NERD-tree'
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"
Bundle 'Tagbar'
" 设置tagbar子窗口的位置出现在主编辑区的左边
let tagbar_right=1
" 设置显示／隐藏标签列表子窗口的快捷键
nnoremap <Leader>tr :TagbarToggle<CR>
" 设置标签子窗口的宽度
let tagbar_width=32
" tagbar子窗口中不显示冗余帮助信息
let g:tagbar_compact=1
" 设置ctags对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" A Vim plugin for visually displaying indent levels in code
Bundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" 设置状态栏主题风格
Bundle 'git://github.com/Lokaltog/vim-powerline.git'
let g:Powerline_colorscheme='solarized256'

" auto recoginize the file encoding
Bundle 'FencView.vim'
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" Alternate Files quickly
Bundle 'a.vim'
" *.cpp和*.h间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示*.cpp 或 *.h
nmap <Leader>sch :AS<CR>

" Plugin to toggle, display and navigate marks
Bundle 'git://github.com/kshenoy/vim-signature.git'
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

" Elegant buffer explorer - takes very little screen space
Bundle 'git://github.com/fholgado/minibufexpl.vim.git'
map <Leader>bl :MBEToggle<cr>
map <Leader>bn :MBEbn<cr>
map <Leader>bu :MBEbp<cr>
map <Leader>fo :MBEFocus<cr>

"Real-time Markdown previews from Vim! 
Bundle 'instant-markdown.vim'
let g:instant_markdown_autostart = 0
map <Leader>mark :InstantMarkdownPreview<cr>

Bundle 'perl-support.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
