language en_US
set nocompatible

call plug#begin('~/.vim/plugged')

" Extend vim
Plug 'tpope/vim-sensible'     "better defaults
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
Plug 'matze/vim-move'
Plug 'christoomey/vim-tmux-navigator'

" Autocomplite
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jreybert/vimagit'

" Snippets
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'

" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'

" css/html
Plug 'othree/html5.vim', { 'for': ['html', 'javascript'] }
Plug 'gregsexton/MatchTag', { 'for': ['html', 'javascript'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'javascript'] }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'JulesWang/css.vim'
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'stylus']  }

" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'elzr/vim-json'
Plug 'mxw/vim-jsx'

" Colorscheme
Plug 'arcticicestudio/nord-vim'
Plug 'tyrannicaltoucan/vim-deep-space'

" Russian keymap support
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

call plug#end()

syntax enable    " enable syntax processing

let g:airline_powerline_fonts = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" FZF
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :Files <CR>
nnoremap <silent> <C-b> :Buffers<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

set autoread

" UI Config
set nocompatible
set hidden
set number   " show line numbers
set cursorline   " highlight current line
set scrolloff=10
set showmode
set showcmd   " show command in bottom bar
set wildmenu    " visual autocomplete for command menu
set wildmode=full
set lazyredraw   " redraw only when we need to.
set showmatch   " highlight matching [{()}]
set visualbell
set t_vb=

" Search
set incsearch   " search as characters are entered
set hlsearch   " highlight matches

" Identation
filetype indent on   " load filetype-specific indent files
set tabstop=2   " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=2
set smarttab
set expandtab   " tabs are spaces
set autoindent
set smartindent
set pastetoggle=<F2>
set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

" Folding
set foldenable    " enable folding
set foldmethod=syntax
set foldlevelstart=10    " open most folds by default
set foldnestmax=10    " 10 nested fold max

set wrap
set linebreak
set nrformats=

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile

" Colors
set termguicolors
colorscheme nord

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Mapings
let mapleader=","

let g:EasyMotion_do_mapping = 0
nmap <leader>f <Plug>(easymotion-overwin-f)

" Save
map <leader>w <esc>:w<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line S is covered by cc.
nnoremap S mzi<CR><ESC>`z

" $/^ doesn't do anything
nnoremap $ <NOP>
nnoremap ^ <NOP>

" move to beginning/end of line
nnoremap <leader>b ^
noremap <leader>e $

" highlight last inserted text
nnoremap gV `[v`]

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" space toggle folds
nnoremap <space> za

" Better ex-mode navigation(with filtering commands)
cnoremap <C-n> <Up>
cnoremap <C-p> <Down>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
" map <C-c> <C-w>c

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
nmap <silent> <leader><leader> :NERDTreeToggle<CR>

" Upper/lower word
nmap <leader>uc mQviwU`Q
nmap <leader>lc mQviwu`Q

" Insert blank lines without going into Insert mode
nmap t o<esc>k
nmap T O<esc>j

" Make Y/yy consistent with D/dd and C/cc
nnoremap yy Y
nnoremap Y y$

" Disable <Arrow keys>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Disable ex mode
nnoremap Q <nop>

" Disable recording macros
map q <Nop>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>o :vsp $MYVIMRC<CR>
nnoremap <leader>zsh :vsp ~/.zshrc<CR>
nnoremap <leader>so :so $MYVIMRC<CR>

" toggle undo-tree
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>uf :UndotreeFocus<CR>

" open ag.vim
nnoremap <leader>a :Ag
