-- Set space as leader key
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("opts")
require("lazy").setup("plugins")
-- require("lazy").setup({
--     {
--         "folke/which-key.nvim",
--         event = "VeryLazy",
--         init = function()
--           vim.o.timeout = true
--           vim.o.timeoutlen = 100
--         end,
--         opts = {
--             layout = {
--                 spacing = 2, -- spacing between columns
--                 align = "center", -- align columns left, center or right
--             },
--             triggers_blacklist = {
--                 -- list of mode / prefixes that should never be hooked by WhichKey
--                 -- this is mostly relevant for keymaps that start with a native binding
--                 i = { "j", "k" },
--                 v = { "j", "k" },
--                 -- n = { ">", "<" },
--             },
--         },
--     },
--     "gbprod/yanky.nvim",
-- })
require("mappings")
require("autocmds")

-- require("yanky").setup()
-- vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
-- vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
-- vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
-- vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

-- vim.keymap.set("n", "[y", "<Plug>(YankyPreviousEntry)")
-- vim.keymap.set("n", "]y", "<Plug>(YankyNextEntry)")

-- vim.keymap.set({"n","x"}, "]p", "<Plug>(YankyPutIndentAfterLinewise)")
-- vim.keymap.set({"n","x"}, "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
-- vim.keymap.set({"n","x"}, "]P", "<Plug>(YankyPutIndentAfterLinewise)")
-- vim.keymap.set({"n","x"}, "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

-- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
-- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
-- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
-- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

-- vim.keymap.set({"n","x"}, "=p", "<Plug>(YankyPutAfterFilter)")
-- vim.keymap.set({"n","x"}, "=P", "<Plug>(YankyPutBeforeFilter)")

-- -- require("leap").create_default_mappings()
-- vim.keymap.set("n",        "s", "<Plug>(leap)")
-- vim.keymap.set("n",        "S", "<Plug>(leap-from-window)")
-- vim.keymap.set({"x", "o"}, "s", "<Plug>(leap-forward)")
-- vim.keymap.set({"x", "o"}, "S", "<Plug>(leap-backward)")
