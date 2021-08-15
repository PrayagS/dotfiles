" Basics
set nocompatible
set hidden
filetype plugin indent on
syntax on
set number
set showmatch

set backspace=indent,eol,start
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set autochdir

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Indentation
set expandtab
set softtabstop=4
set shiftwidth=4

" Find
set wildmenu
set path+=**

" Misc
set nobackup
set noswapfile
set wrap
set linebreak
set breakindent

" Splits
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Set better keybindings for tabs
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tw :tabclose<CR>
nnoremap tn :tabnew<CR>

" Colors
" set termguicolors

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

" Always open a new file in a new tab
" autocmd VimEnter * tab all
" autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'lambdalisue/suda.vim'
Plug 'dylanaraps/wal.vim'
call plug#end()

colorscheme wal

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'wal',
      \ }
set laststatus=2
set noshowmode

