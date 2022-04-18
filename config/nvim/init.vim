" Remap leader
let mapleader = " "
let maplocalleader = " "

source ~/.config/nvim/options.vim
source ~/.config/nvim/autocmd.vim

call plug#begin()

" Editor
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'ggandor/lightspeed.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/which-key.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'airblade/vim-rooter'
Plug 'folke/twilight.nvim'
Plug 'akinsho/bufferline.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'junegunn/gv.vim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Files
Plug 'mcchrish/nnn.vim'

" Utils
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'morhetz/gruvbox'
" Plug 'itchyny/lightline.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rebelot/kanagawa.nvim'
Plug 'rose-pine/neovim'
Plug 'huyvohcmc/atlas.vim'
Plug 'aditya-azad/candle-grey'
Plug 'AlessandroYorba/Alduin'
Plug 'cocopon/iceberg.vim'
Plug 'gkeep/iceberg-dark'
Plug 'cseelus/vim-colors-lucid'
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'nikolvs/vim-sunbather'
call plug#end()

source ~/.config/nvim/mappings.vim

call yankstack#setup()

lua << EOF
require('gitsigns').setup()
require("which-key").setup {}
require("twilight").setup {}
require("bufferline").setup {}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = "|",
    section_separators = " ",
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'filetype',
        icon_only = true,
        separator = '',
      },
      {
        'filename',
        file_status = true,      -- Displays file status (readonly status, modified status)
        path = 1,                -- 0: Just the filename
                                 -- 1: Relative path
                                 -- 2: Absolute path

        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                                 -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = ' [+]',      -- Text to show when the file is modified.
          readonly = ' [-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = ' [No Name]', -- Text to show for unnamed buffers.
        }
      }
    },
    lualine_x = {'encoding', 'fileformat'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF


" indent blankline
lua << EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}
EOF

" nnn
let $NNN_PLUG="z:autojump;d:dragdrop;c:fzcd;f:fzopen;p:preview-tabbed;"
let $NNN_TRASH="1"
let $NNN_OPTS="adexDHU"

" Lightline config
let g:lightline = {'colorscheme': 'minimal'}
set laststatus=2
set noshowmode

" gruvbox
" let g:gruvbox_transparent_bg = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_invert_signs = 1
set background=dark
colorscheme gruvbox
let g:lightline = {'colorscheme': 'gruvbox'}

" tokyonight
" let g:tokyonight_style = 'night'
" colorscheme tokyonight
" let g:lightline = {'colorscheme': 'tokyonight'}

" catppuccin
" lua << EOF
" local catppuccin = require("catppuccin")
" -- configured directly in plugged/
" catppuccin.setup({
"   transparent_background = false,
"   integrations = {
"     gitgutter = true,
"     lightspeed = true
"   }
" })
" EOF
" colorscheme catppuccin
" let g:lightline = {'colorscheme': 'catppuccin'}

" kanagawa
" colorscheme kanagawa

" rose-pine
" set background=light
" colorscheme rose-pine

" atlas
" colorscheme atlas
" let g:lightline.colorscheme = 'atlas'

" candle-grey
" colorscheme candle-grey
" colorscheme candle-grey-transparent

" alduin
" let g:alduin_Shout_Dragon_Aspect = 1
" let g:alduin_Shout_Become_Ethereal = 1
" colorscheme alduin

" iceberg
" colorscheme iceberg
" let g:lightline.colorscheme = 'icebergDark'

" lucid
" colorscheme lucid

" onedark
" colorscheme onedark
" let g:lightline.colorscheme = 'onedark'

" onehalf
" colorscheme onehalfdark
" let g:lightline_theme='onehalfdark'

" sunbather
" colorscheme sunbather

lua << EOF
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    width = 30,
    height = 30,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 400,
  },
  actions = {
    change_dir = {
      enable = false,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
} -- END_DEFAULT_OPTS
EOF
