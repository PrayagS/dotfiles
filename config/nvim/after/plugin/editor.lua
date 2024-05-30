require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
    ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
})

require("Comment").setup()

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

require("nvim-surround").setup()

require("yanky").setup()
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "[y", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "]y", "<Plug>(YankyNextEntry)")

vim.keymap.set({"n","x"}, "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set({"n","x"}, "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set({"n","x"}, "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set({"n","x"}, "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set({"n","x"}, "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set({"n","x"}, "=P", "<Plug>(YankyPutBeforeFilter)")
