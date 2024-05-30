return {
    "windwp/nvim-autopairs",
    "numToStr/Comment.nvim",
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },
    "gbprod/yanky.nvim",
    "airblade/vim-rooter",
    "lambdalisue/suda.vim",
    -- {
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     opts = {
    --         max_count = 5,
    --         allow_different_key = true,
    --         restriction_mode = "hint",
    --     }
    -- },
}
