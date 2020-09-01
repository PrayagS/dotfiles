" Basics
filetype plugin indent on
syntax on
set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set wrap
set linebreak

" Some shortcuts
vnoremap <C-c> "+y
map <C-x> "+P

" Colors
" set termguicolors
set background=dark
syntax enable

autocmd BufWritePost *.c !gcc "%" -o "%:r"
autocmd BufWritePost *.sh !shellcheck "%"
" Set scripts to be executable from the shell
autocmd BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x "%" | endif | endif
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

autocmd FileType markdown setlocal spell spelllang=en_us

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
call plug#end()

