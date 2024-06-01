return {
    {
        "ggandor/leap.nvim",
        lazy = false,
        opts = {},
        config = function()
            vim.keymap.set("n",        "s", "<Plug>(leap)")
            vim.keymap.set("n",        "S", "<Plug>(leap-from-window)")
            vim.keymap.set({"x", "o"}, "s", "<Plug>(leap-forward)")
            vim.keymap.set({"x", "o"}, "S", "<Plug>(leap-backward)")

            require("leap.user").set_repeat_keys("<enter>", "<backspace", {
                relative_directions = true,
            })
        end,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.bracketed").setup({
                yank = { suffix = '', options = {} },
            })
        end,
    },
    {
        "ggandor/flit.nvim",
        lazy = false,
        config = function()
            require('flit').setup {
                keys = { f = 'f', F = 'F', t = 't', T = 'T' },
                labeled_modes = "v",
                multiline = true,
                opts = {}
            }
        end,
    },
    -- { "tpope/vim-repeat", event = "VeryLazy" },
}
