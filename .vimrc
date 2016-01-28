set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Extend vim
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'     "better defaults
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'

" Autocomplite
Plugin 'ervandew/supertab'
Plugin 'mattn/emmet-vim'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Syntax support
Plugin 'othree/html5.vim'
Plugin 'wavded/vim-stylus'
Plugin 'pangloss/vim-javascript'

" Colorscheme
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'raphamorim/lucario'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()
syntax on
filetype on
filetype plugin indent on
filetype plugin on

" Syntastic settings
let g:syntastic_javascript_checkers = ['eslint', 'jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" UI Config
set nocompatible
set hidden
set number                       " show line numbers
set cursorline                   " highlight current line
set showmode
set showcmd                      " show command in bottom bar
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]

" Search
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" Identation
set tabstop=2                    " number of visual spaces per TAB
set shiftwidth=2
set smarttab
set expandtab                    " tabs are spaces
set autoindent
set smartindent
set pastetoggle=<F2>
set list
set listchars=tab:▸\ ,eol:¬

set wrap
set linebreak

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Colors
" set background=dark
" colorscheme gruvbox
set t_Co=256
colorscheme jellybeans

" Mapings
let mapleader=","

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
" map <C-c> <C-w>c

nmap <silent> <leader><leader> :NERDTreeToggle<CR>

" Upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" Disable <Arrow keys>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

