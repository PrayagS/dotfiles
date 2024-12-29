local opt = vim.opt

vim.g.mapleader = " "
vim.g.autoformat = true

-- Basics
opt.number = true
opt.relativenumber = true
opt.backspace = [[indent,eol,start]]
opt.title = true
opt.list = true
opt.autochdir = true
-- opt.colorcolumn = [[80]]
opt.swapfile = false
opt.textwidth = 80
opt.linebreak = true
opt.splitbelow = true
opt.splitright = true
opt.breakindent = true
opt.showmatch = true
opt.inccommand = "split"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true -- Round indent
opt.smartindent = true -- Insert indents automatically
opt.termguicolors = true -- True color support
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- Find
opt.wildmode = [[longest,list,full]]
opt.path:append("**")

-- Avoid copying line numbers when using mouse
opt.mouse:append("a")

opt.autowrite = true -- Enable auto write
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true
-- opt.cursorline = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.undofile = true

local space = "·"

opt.list = true
opt.listchars = {
	lead = "·",
	trail = "•",
	multispace = "∅",
	nbsp = "‡",
	tab = " » ",
	precedes = "❮",
	extends = "❯",
	-- eol = "↵",
	-- eol = "⤶",
}

opt.showmode = false
opt.updatetime = 1000
opt.laststatus = 3
opt.signcolumn = "auto:9"
opt.sessionoptions = "buffers,curdir,folds,help,localoptions,tabpages,winsize,winpos"
