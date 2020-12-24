" Basics
filetype plugin indent on
syntax on
set number
set showmatch
set colorcolumn=80

" Search
set incsearch
set ignorecase
set smartcase
set nohlsearch

" Indentation
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=0
set shiftwidth=4

" Misc
set nobackup
set noswapfile
set wrap
set linebreak
set breakindent
set clipboard=unnamedplus

" Splits
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Colors
" set termguicolors
set background=dark
syntax enable

" Find
set hidden
set wildmenu
set path+=**

" Compile .c files on save
autocmd BufWritePost *.c !gcc "%" -o "%:r"

" Show shellcheck report on save
autocmd BufWritePost *.sh !shellcheck "%"

" Set scripts to be executable from the shell
autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x "%" | endif | endif

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Turn on spell check for markdown files
autocmd FileType markdown setlocal spell spelllang=en_us

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
call plug#end()

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ }
set laststatus=2
set noshowmode
