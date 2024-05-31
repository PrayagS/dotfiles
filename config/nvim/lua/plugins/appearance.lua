return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
        -- priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    "projekt0n/github-nvim-theme",
    "rebelot/kanagawa.nvim",
    "folke/tokyonight.nvim",
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 100
        end,
        opts = {
            layout = {
                spacing = 2, -- spacing between columns
                align = "center", -- align columns left, center or right
            },
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for keymaps that start with a native binding
                i = { "j", "k" },
                v = { "j", "k" },
                -- n = { ">", "<" },
            },
        },
    },
    {
        dependencies = {
        },
    },
    "nvim-tree/nvim-web-devicons",
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    "lukas-reineke/indent-blankline.nvim",
    "folke/zen-mode.nvim",
    "kevinhwang91/nvim-hlslens",
    "kevinhwang91/nvim-bqf",
    "m4xshen/smartcolumn.nvim",
    {
        "code-biscuits/nvim-biscuits",
        keys = {
            {
                "<leader>bb",
                function()
                    require("nvim-biscuits").BufferAttach()
                end,
                mode = "n",
                desc = "Enable Biscuits",
            },
        },
    },
    "karb94/neoscroll.nvim",
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "smjonas/live-command.nvim",
        name = "live-command",
    },
}
