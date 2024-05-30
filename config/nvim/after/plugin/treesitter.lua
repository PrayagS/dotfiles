local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = {
        "bash",
        "c", "cpp", "cue",
        "dockerfile",
        "git_config", "go", "gomod", "gotmpl",
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
})

require("treesitter-context").setup({
    enable = true,
})
