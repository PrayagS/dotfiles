return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_formatter_opts = {
                relative_time = true,
            },
        },
    },
    {
        "linrongbin16/gitlinker.nvim",
        opts = {},
        keys = {
            { "<leader>gL", "<cmd>lua require('gitlinker').link({ action = require('gitlinker.actions').system })<cr>", mode = { "n", "v"}, desc = "GitLink!" },
            { "<leader>gB", "<cmd>lua require('gitlinker').link({ router_type = 'blame', action = require('gitlinker.actions').system })<cr>", mode = { "n", "v"}, desc = "GitLink! blame" },
            { "<leader>gD", "<cmd>lua require('gitlinker').link({ router_type = 'default_branch', action = require('gitlinker.actions').system })<cr>", mode = { "n", "v"}, desc = "GitLink! default_branch" },
            { "<leader>gC", "<cmd>lua require('gitlinker').link({ router_type = 'current_branch', action = require('gitlinker.actions').system })<cr>", mode = { "n", "v"}, desc = "GitLink! current_branch" },
        },
    },
    {
        "sindrets/diffview.nvim",
        opts = {},
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
            "DiffviewFileHistory",
            "DiffviewLog",
        },
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
           { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    }
}
