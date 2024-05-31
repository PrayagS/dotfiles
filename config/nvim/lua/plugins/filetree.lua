return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
        require("nvim-tree").setup({
            hijack_cursor = true,
            sync_root_with_cwd = true,
            view = {
                centralize_selection = true,
            },
            renderer = {
                add_trailing = true,
                group_empty = true,
                indent_markers = {
                    enable = true,
                },
            },
            diagnostics = {
                enable = true,
            },
            tab = {
                sync = {
                    open = true,
                },
            },
        })
        vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
}
