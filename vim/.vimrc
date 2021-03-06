"一							vundle 控制插件

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set nocompatible              " be iMproved, required
filetype off                  " required
" 使用Vundle来管理插件，这个必须要有。
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/a.vim'
"Plugin 'auto-pairs'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
"Plugin 'nerdcommenter'
Plugin 'iamcco/markdown-preview.vim'
"Plugin 'Rip-Rip/clang-complete'
"Plugin 'Yggdroot/indentLine'
Plugin 'iamcco/dict.vim'
call vundle#end()            " required
filetype plugin indent on    " required
"clang-complate 配置
let g:clang_library_path='/usr/lib/llvm-3.8/lib/'
"YouCompleteMe 插件配置
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path = '/usr/bin/python3'
nmap<C-a> :YcmCompleter FixIt<CR>
"markdown_preview 插件设置

let g:mkdp_path_to_chrome = "google-chrome"
let g:mkdp_auto_start = 0
let g:mkdp_auto_open = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
nmap <silent> <F9> <Plug>MarkdownPreview        
imap <silent> <F9> <Plug>MarkdownPreview        
map <F10> <Plug>StopMarkdownPreview    
" 有道翻译插件
let g:api_key = "1932136763"
let g:keyfrom = "aioiyuuko"
" tagbar 插件配置
nmap tb :TlistClose<CR>:TagbarToggle<CR>
" nerdtree 插件配置
" m 显示文件选项 
map <C-n> :NERDTreeToggle<CR>
map tc :tabclose<CR>
map tn :tabNext<CR>
map tl :tablast<CR>
map tf :tabfirst<CR>
let g:tagbar_width=15                      "设置窗口宽度
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=25
" ultisnips and vim-snippets 设置
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<C-a>"
let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
" syntastic 设置
""let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
""let g:syntastic_enable_highlighting = 1
""let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
"二							基础配置

set number
set noexpandtab 		" 不要用空格代替制表符
" 设置(软)制表符宽度为4
set tabstop=4			
set softtabstop=4
set shiftwidth=4 		" 设置缩进空格为4
set helplang=cn
set encoding=utf-8
set foldenable      	" 允许折叠  
set foldmethod=manual  	" 手动折叠  
set noexpandtab			" 不要用空格代替制表符
set smarttab			" 在行和段开始处使用制表符
set history=1000		" 历史记录数
set nobackup			" 禁止生成临时文件
set autoread			" 设置当文件被改动时自动载入
set noswapfile			" 不生成交换文件
"# 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set laststatus=2		" 在倒数第二行显示状态栏
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
set modifiable			" 允许修改
"三							为C程序提供自动缩进
set smartindent
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap { {<CR>}<ESC>O
"inoremap } <c-r>=ClosePair('}')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
"四							编译运行程序

" F5 运行C,C++,shell,python3
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'python'
		exec "!python3 %"
	elseif &filetype == 'sh'
		:!./%
	endif
endfunc
" F8 C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!cgdb ./%<"
endfunc
