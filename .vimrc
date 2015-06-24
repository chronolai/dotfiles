let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	let iCanHazVundle=0
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on
" Put your non-Plugin stuff after this line
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-javascript'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar' " sudo apt-get install exuberant-ctags
Plugin 'marijnh/tern_for_vim' " cd ~/.vim/bundle/tern_for_vim ;npm install
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'

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

map <leader>t :TagbarToggle<CR>
map <leader>n :NERDTreeTabsToggle<CR>
map <leader>g :GundoToggle<CR>
map <leader>a :!ack-grep 
map <leader>x :tabnext<CR>
map <leader>z :tabprev<CR>
map <leader>b :Gblame<CR>
map <leader>d :Gdiff<CR>

map <C-_> <leader>ci
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
colorscheme molokai
set t_Co=256
set encoding=utf-8
set fileencodings=utf-8,cp950
set nocompatible
set ai
set shiftwidth=4
set tabstop=4
set softtabstop=4
set ruler
set nu
set ic
set ru
set hlsearch
set incsearch
set smartindent
set cursorline
set list listchars=tab:\¦\ ,trail:.
set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus " sudo apt-get install vim-gtk

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
