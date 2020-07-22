set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" syntac highlighting
Plugin 'sheerun/vim-polyglot'

" color themes
Plugin 'flazz/vim-colorschemes'

" project navigation
Plugin 'scrooloose/nerdtree' | Plugin 'jistr/vim-nerdtree-tabs' | Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
" Plugin '/usr/local/opt/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'

" real time linting
Plugin 'w0rp/ale'

" code navigation
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

" code snips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" go
Plugin 'fatih/vim-go'

" others
Plugin 'tpope/vim-fugitive'  " git插件
Plugin 'luochen1990/rainbow'  " 彩虹括号
Plugin 'tpope/vim-surround'  " 快速修改括号和冒号
Plugin 'Yggdroot/indentLine'  " 显示缩进线
Plugin 'tpope/vim-commentary'  " 代码快速注释

" code navigation
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ==================== base setting ===========================
set encoding=utf-8
set autowrite
syntax on  " 代码高亮

" 冒号进入命令模式
map ; :
noremap ;; ;
" 行号
set number relativenumber
set wrap                     " 取消换行
" python 断点
nnoremap <leader>o oimport ipdb; ipdb.sset_trace()<Esc>
" 快速复制
vmap <C-c> "+y
" 禁止生成临时文件
set nobackup
set noswapfile
" ex命令自动补全
set wildmenu
set wildmode=full
" 修改保存的历史命令的条数（默认为20）
set history=100
" 窗口切换
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" 搜索配置
nnoremap / /\v
vnoremap / /\v
" 设置文内智能搜索提示
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 自动缩进
set autoindent 
set cindent 
set tabstop=4 
set shiftwidth=2 
set expandtab

" ==================== colorschemes ===========================
let python_highlight_all = 1  " 加强python高亮

" ==================== status bar ===========================
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='tomorrow'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇ '

" ==================== ale ===========================
let g:ale_completion_enabled = 1

" ==================== jedi-vim ===========================
" 自动补全时禁止显示docstring
autocmd FileType python setlocal completeopt-=preview

" ==================== supertab ===========================
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
set omnifunc=syntaxcomplete#Complete

" ==================== colorschemes ===========================
set termguicolors
colorscheme gruvbox
set background=dark

" ==================== nerdtree ===========================
let g:NERDTreeMapOpenSplit = 's' 
let g:NERDTreeMapOpenVSplit = 'v' 
nmap <C-n> :NERDTreeToggle<CR> 
let NERDTreeWinSize=30 
let NERDTreeIgnore=['.pyc', '\.swp', '\~', '__pycache__/'] 
" 是否自动开启nerdtree 
" let g:nerdtree_tabs_open_on_console_startup=1 
" let g:nerdtree_tabs_open_on_gui_startup=1 
" close vim if the only window left open is a NERDTree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end 
let g:NERDTreeIndicatorMapCustom = { 
    \ "Modified"  : "✹", 
    \ "Staged"    : "✚", 
    \ "Untracked" : "✭", 
    \ "Renamed"   : "➜", 
    \ "Unmerged"  : "═", 
    \ "Deleted"   : "✖", 
    \ "Dirty"     : "✗", 
    \ "Clean"     : "✔︎", 
    \ 'Ignored'   : '☒', 
    \ "Unknown"   : "?" 
    \ }

" ==================== fzf ===========================
" This is the default extra key bindings

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>A :Ag<CR>

" ==================== ctrlp ===========================
" 设置搜索时忽略的文件
" let g:ctrlp_custom_ignore = {
"     \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
"     \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
"     \ }
" " nmap <C-b> :CtrlPBuffer<CR>
" let g:ctrlp_max_files=0
" let g:ctrlp_working_path_mode = 'a'

" ==================== TagBar ===========================
nmap <F8> :TagbarToggle<CR>

" ==================== gutentags ===========================
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_exclude = ["*.min.js", "*.pyc", "*.min.css", "build", "vendor", ".git", "node_modules", "*.vim/bundle/*"]
let g:gutentags_ctags_executable = '/usr/local/Cellar/universal-ctags/HEAD-f6c7064/bin/ctags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_enabled = 1
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" let g:gutentags_trace = 1

" ==================== rainbow ===========================
let g:rainbow_active = 1  " 彩虹括号

" ==================== commentary ===========================
" 为python和shell等添加注释
autocmd FileType python,shell,coffee set commentstring=#\ %s
" 修改注释风格
autocmd FileType java,c,cpp set commentstring=//\ %s
