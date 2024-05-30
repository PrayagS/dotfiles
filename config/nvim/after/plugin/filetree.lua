require("nvim-tree").setup({
    tab = {
        sync = {
            open = true,
        },
    },
})

vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
