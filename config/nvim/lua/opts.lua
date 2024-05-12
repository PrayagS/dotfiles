
vim.g.mapleader = " "

-- Basics
vim.opt.relativenumber = true
vim.opt.backspace = [[indent,eol,start]]
vim.opt.title = true
vim.opt.list = true
vim.opt.autochdir = true
vim.opt.colorcolumn = [[80]]
vim.opt.swapfile = false
vim.opt.textwidth = 80
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.breakindent = true
vim.opt.showmatch = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true -- Round indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.termguicolors = true -- True color support
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- Find
vim.opt.wildmode = [[longest,list,full]]
vim.opt.path:append '**'

-- Avoid copying line numbers when using mouse
vim.opt.mouse:append 'a'

vim.g.autoformat = true
vim.opt.autowrite = true -- Enable auto write
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.undofile = true
