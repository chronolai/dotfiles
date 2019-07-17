" ----------------------------------------
" VimPlug Scripts
" ----------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'wakatime/vim-wakatime'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'leafgarland/typescript-vim'
Plug 'chemzqm/vim-jsx-improve'
call plug#end()

" ----------------------------------------
" Plugin Setting
" ----------------------------------------
"
let g:syntastic_javascript_checkers = ['eslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
let g:formatters_javascript = ['eslint']

" NERDCommenter
let g:NERDSpaceDelims = 1
" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.sw[po]$']
let NERDTreeShowHidden=1
let g:nerdtree_tabs_autoclose=1
" NERDTreeTabs
" let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_focus_on_files=1
" Airline
let g:airline_theme='molokai'
" Molokai
let g:molokai_original=1
let g:rehash256=1
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
" vim-better-whitespace
let g:strip_whitespace_confirm=0
let g:strip_whitespace_on_save=1
let g:better_whitespace_filetypes_blacklist=['vim']
" GitGutter
let g:gitgutter_realtime=1
let g:gitgutter_enabled=1
let g:gitgutter_max_signs=50000
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_action = {
  \ 'enter': 'tab split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
      \{
      \  'fg':      ['fg', 'Normal'],
      \  'bg':      ['bg', 'Normal'],
      \  'hl':      ['fg', 'Comment'],
      \  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \  'hl+':     ['fg', 'Statement'],
      \  'info':    ['fg', 'PreProc'],
      \  'border':  ['fg', 'Ignore'],
      \  'prompt':  ['fg', 'Conditional'],
      \  'pointer': ['fg', 'Exception'],
      \  'marker':  ['fg', 'Keyword'],
      \  'spinner': ['fg', 'Label'],
      \  'header':  ['fg', 'Comment']
      \}

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" ----------------------------------------
" Key Mapping
" ----------------------------------------
map <leader>n :call ToggleNERDTree()<CR>
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
map <C-p> :FZF<CR>
map <C-o> :Rg<CR>

nnoremap <F12> :call ToggleMouse()<CR>
" ----------------------------------------
" Global Setting
" ----------------------------------------
syntax on
set autoindent
set number
set ignorecase
set ruler
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set t_Co=256
set encoding=utf-8
set fileencodings=utf-8,cp950
set hlsearch
set incsearch
set showcmd
set smartindent
set cursorline
set colorcolumn=120
set textwidth=120
set showtabline=2
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

function! IsNerdTreeEnabled()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! ToggleMouse()
  if &mouse == 'a'
    if winnr('$') > 1
      :only
    endif
    set nonu
    set mouse-=a
    set nolist
    :GitGutterDisable
    echo "Copy Mode enabled"
  else
    set nu
    set mouse=a
    set list
    :GitGutterEnable
    echo "Copy Mode disabled"
  endif
endfunction

function! ToggleNERDTree()
  if IsNerdTreeEnabled() 
    :NERDTreeClose
  else
    let g:NERDTreeWinSize=31
    :NERDTree
  endif
endfunction
