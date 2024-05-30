-- Set transparency
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require("rose-pine").setup({
    variant = "main",
    dark_variant = "main",
    dim_inactive_windows = false,
    styles = {
        transparency = true,
    },
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
    no_italic = true, -- Force no italic
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
    },
})

-- Set colorscheme
vim.cmd.colorscheme("catppuccin")

require("surround-ui").setup({
    root_key = "S"
})

require("nvim-web-devicons").setup()

require("bufferline").setup({
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
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

require("ibl").setup()

require("zen-mode").setup({
    plugins = {
        kitty = {
            enabled = true,
            font = "+4", -- font size increment
        },
    }
})

require('hlslens').setup()

local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

require("bqf").setup({
    preview = {
        show_scroll_bar = false,
        winblend = 50,
    },
})

require("smartcolumn").setup()

require("nvim-biscuits").setup({
    max_length = 40,
    trim_by_words = true,
})

require('neoscroll').setup()

require('lualine').setup({
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
            -- {
            --     'buffers',
            --     mode = 2,
            --     use_mode_colors = true,
            -- },
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
})

require("live-command").setup({
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
})
