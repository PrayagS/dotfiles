" Basics
set nocompatible
set hidden
filetype plugin indent on
syntax on
set number relativenumber
set backspace=indent,eol,start
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set autochdir
set colorcolumn=80
" set cursorline
set nobackup
set noswapfile
set textwidth=80
set wrapmargin=0
set wrap
set linebreak
set splitbelow splitright
set breakindent
set showmatch

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Indentation
set expandtab
set softtabstop=4 tabstop=4
set shiftwidth=4

" Find
set wildmode=longest,list,full
set wildmenu
set path+=**

" Avoid copying line numbers when using mouse
se mouse+=a

" Better clipboard
set clipboard^=unnamed,unnamedplus

" Colors
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
