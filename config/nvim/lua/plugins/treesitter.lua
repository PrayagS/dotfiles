return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- lazy = false,
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            ensure_installed = {
                "bash",
                "c", "cpp", "cue",
                "dockerfile",
                "git_config", "gitcommit",
                "go", "gomod", "gotmpl",
                "json",
                "lua",
                "markdown",
                "promql", "python",
                "rust",
                "terraform",
                "yaml",
                "vimdoc",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        opts = {},
    },
}
