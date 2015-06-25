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
NeoBundle 'vim-javascript'
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
call neobundle#end()
filetype plugin indent on

NeoBundleCheck

" ----------------------------------------
" Plugin Setting
" ----------------------------------------
" NERDTree
let NERDTreeShowHidden=1
let g:nerdtree_tabs_autoclose=1
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

" ----------------------------------------
" Key Mapping
" ----------------------------------------
map <leader>t :TagbarToggle<CR>
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>g :GundoToggle<CR>
map <leader>a :!ack-grep 
map <leader>x :tabnext<CR>
map <leader>z :tabprev<CR>
map <leader>b :Gblame<CR>
map <leader>d :Gdiff<CR>
map <C-_> <leader>ci

" ----------------------------------------
" Global Setting
" ----------------------------------------
syntax on
set ai
set nu
set ic
set ru
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
set colorcolumn=80
set list listchars=tab:\¦\ ,trail:.
set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus " sudo apt-get install vim-gtk
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
		echo "Copy Mode enabled"
	else
		set nu
		set mouse=a
		set list
		:NERDTreeTabsOpen
		execute "normal \<c-w>l"
		echo "Copy Mode disabled"
	endif
endfunction
