return {
    {
        "nvim-lua/plenary.nvim",
        lazy = false,
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        config = function()
            require('kitty-scrollback').setup({
                {
                    status_window = {
                        style_simple = true,
                    },
                    visual_selection_highlight_mode = 'kitty',
                    restore_options = true,
                },
            })
        end,
    },
}
