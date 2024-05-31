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
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true, -- disables setting the background color.
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                which_key = true,
                treesitter = true,
                treesitter_context = true,
                diffview = true,
                leap = true,
                telescope = {
                    enabled = true,
                    -- style = "nvchad"
                },
                indent_blankline = {
                    enabled = true,
                    scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = true    ,
                },
                mason = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                        ok = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                        ok = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
            },
        },
        init = function()
            vim.cmd.colorscheme("catppuccin")
        end,
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
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                max_name_length = 50,
                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = true,
                separator_style = "thick",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "Explorer",
                        text_align = "center",
                        separator = true,
                        offset_separator = true,
                        -- highlight = "Directory",
                        -- padding = "200",
                    }
                },
            },
        },
        -- Separate function to load as we require catppuccin to configure highlights
        config = function(_, opts)
            require("bufferline").setup({
                options = opts.options,
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    },
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
                plugins = {
                    kitty = {
                        enabled = true,
                        font = "+4", -- font size increment
                    },
                }
            })
        end,
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = "VeryLazy",
        config = function()
            require('hlslens').setup()
            local kopts = {noremap = false, silent = true}
            -- Not setting n and N as they're being set by cinnamon
            -- vim.api.nvim_set_keymap('n', 'n',
            --     [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            --     kopts)
            -- vim.api.nvim_set_keymap('n', 'N',
            --     [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            --     kopts)
            vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            preview = {
                show_scroll_bar = false,
                winblend = 50,
            },
        },
    },
    { "m4xshen/smartcolumn.nvim", opts = {}, },
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
    {
        'declancm/cinnamon.nvim',
        config = function()
            require('cinnamon').setup({
                extra_keymaps = true,
                extended_keymaps = true,
                hide_cursor = true,
            })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = "",
                section_separators = "",
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    'mode',
                },
                lualine_b = {
                    'branch',
                    {
                        "diff",
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                        always_visible = false,
                    },
                    'diagnostics'
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    },
                },
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {
                "lazy",
                "nvim-tree",
                "quickfix",
            },
        },
    },
    {
        "smjonas/live-command.nvim",
        name = "live-command",
        event = "VeryLazy",
        opts = {
            defaults = {
                enable_highlighting = true,
                inline_highlighting = true,
                hl_groups = {
                insertion = "DiffAdd",
                deletion = "DiffDelete",
                change = "DiffChange",
                },
            },
            commands = {
                Norm = { cmd = "norm" },
                G = { cmd = "g" },
                D = { cmd = "d" },
                Reg = {
                    cmd = "norm",
                    args = function(opts)
                    return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
                    end,
                    range = "",
                },
            },
        },
    },
}
