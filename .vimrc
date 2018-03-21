" ----------------------------------------
" NeoBundle Scripts
" ----------------------------------------
let readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(readme)
	echo "Installing NeoBundle..\n"
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Add or remove your Bundles here:
NeoBundle 'ervandew/supertab'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'tomasr/molokai'
NeoBundle 'Lokaltog/vim-powerline'
"NeoBundle 'vim-javascript'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'
NeoBundle 'majutsushi/tagbar' " sudo apt-get install exuberant-ctags
NeoBundle 'marijnh/tern_for_vim' " cd ~/.vim/bundle/tern_for_vim ;npm install
NeoBundle 'mattn/emmet-vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'csscomb/vim-csscomb' " npm install -g csscomb
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'Shutnik/jshint2.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'mindriot101/vim-yapf'
NeoBundle 'digitaltoad/vim-pug'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
call neobundle#end()
filetype plugin indent on

NeoBundleCheck

" ----------------------------------------
" Plugin Setting
" ----------------------------------------
"
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 0
" NERDTree
let NERDTreeShowHidden=1
let g:nerdtree_tabs_autoclose=1
let NERDTreeIgnore = ['\.pyc$', '\.sw[po]$']
" NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_focus_on_files=1
" Molokai
let g:molokai_original=1
let g:rehash256=1
" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_prompt_mappings = {
	\ 'AcceptSelection("e")': [],
	\ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
\ }
" Gundo
let g:gundo_right=1
" GitGutter
let g:gitgutter_realtime=1
let g:gitgutter_enabled=1
let g:gitgutter_max_signs=50000
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:strip_whitespace_on_save=1
let g:better_whitespace_filetypes_blacklist=['vim']
let jshint2_save=1
" clang format
let g:clang_format#command = "clang-format-3.8"
let g:clang_format#detect_style_file = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

" ----------------------------------------
" Key Mapping
" ----------------------------------------
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>t :TagbarToggle<CR>
map <leader>gd :GundoToggle<CR>
map <leader>gbl :Gblame<CR>
map <leader>gdf :Gdiff<CR>
map <leader>gst :Gstatus<CR>
map <leader>glg :Glog<CR>
map <leader>gla :!git la<CR>
map <leader>bc :CSScomb<CR>
map <leader>ttr :ToggleStripWhitespaceOnSave<CR>
map <leader>a :Ack 
map <leader>rr :%s/\r//g<CR>
map <leader>rs :%s/\t/  /g<CR>
map <leader>s :'<,'>sort u<CR>
map <leader>st2 :set expandtab ts=2 sts=2 sw=2<CR>
map <leader>st4 :set expandtab ts=4 sts=4 sw=4<CR>

map <C-_> <leader>ci
map <C-l> :tabnext<CR>
map <C-h> :tabprev<CR>
map <C-j> :tabe 
map <C-k> :q<CR>

" ----------------------------------------
" Global Setting
" ----------------------------------------
syntax on
set ai
set nu
set ic
set ru
set wildmenu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set t_Co=256
set encoding=utf-8
set fileencodings=utf-8,cp950
set ruler
set hlsearch
set incsearch
set smartindent
set cursorline
set colorcolumn=120
set list listchars=tab:\¦\ ,trail:.
set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus " sudo apt-get install vim-gtk
set ffs=unix
set diffopt+=vertical
colorscheme molokai

" ----------------------------------------
" Customize Function
" ----------------------------------------
nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
	if &mouse == 'a'
		:only
		set nonu
		set mouse-=a
		set nolist
		:GitGutterDisable
		echo "Copy Mode enabled"
	else
		set nu
		set mouse=a
		set list
		:NERDTreeTabsOpen
		:GitGutterEnable
		execute "normal \<c-w>l"
		echo "Copy Mode disabled"
	endif
endfunction
