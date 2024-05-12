return {
    -- the colorscheme should be available when starting Neovim
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
          -- load the colorscheme here
          vim.cmd([[colorscheme catppuccin]])
        end,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            transparent_background = true, -- disables setting the background color.
            show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
            term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = true, -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                enabled = true,
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        opts = {
            enable_check_bracket_line = false,
            ignored_next_char = "[%w%.]" -- will ignore alphanumeric and `.` symbol
        },
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     event = "VeryLazy",
    --     config = function()
    --         require("nvim-surround").setup({
    --             -- Configuration here, or leave empty to use defaults
    --         })
    --     end
    -- },
    {
        "gbprod/yanky.nvim",
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        },
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').create_default_mappings()
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
        end,
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    },
    {
        "folke/twilight.nvim",
        opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        }
    },
    {
        "folke/zen-mode.nvim",
        opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        }
    },
    {
        "airblade/vim-rooter",
    },
    {
        "lambdalisue/suda.vim",
    },
    {
        "junegunn/fzf.vim",
    },
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lua",
          "chrisgrieser/cmp_yanky",
          "onsails/lspkind.nvim",
        },
        opts = function()
          vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
          local cmp = require("cmp")
          local defaults = require("cmp.config.default")()
          local lspkind = require("lspkind")
          return {
            completion = {
              completeopt = "menu,menuone,noinsert",
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
              ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<tab>"] = cmp.config.disable,
              ["<C-e>"] = cmp.mapping.abort(),
            --   ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              ["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              ["<C-CR>"] = function(fallback)
                cmp.abort()
                fallback()
              end,
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "path" },
            }, {
              { name = "buffer" },
            }, {
              { name = 'nvim_lua' },
            }, {
              { name = "cmp_yanky" },
            }),
            experimental = {
              ghost_text = {
                hl_group = "CmpGhostText",
              },
            },
            sorting = defaults.sorting,
            formatting = {
                format = lspkind.cmp_format {
                  mode = "symbol_text",
                  menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[api]",
                    path = "[path]",
                  },
                },
              },
          }
        end,
        ---@param opts cmp.ConfigSchema
        config = function(_, opts)
          for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
          end
          require("cmp").setup(opts)
        end,
    },
    {
        "onsails/lspkind.nvim",

    },
    {
        "hrsh7th/cmp-nvim-lsp",
        after = "nvim-cmp",
    },
    {
        "hrsh7th/cmp-buffer",
        after = "nvim-cmp",
    },
    {
        "hrsh7th/cmp-path",
        after = "nvim-cmp",
    },
    {
        "hrsh7th/cmp-cmdline",
        after = "nvim-cmp",
        config = function()
            -- `/` cmdline setup.
            local cmp = require("cmp")
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                { name = 'buffer' }
                }
            })
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                { name = 'path' }
                }, {
                {
                    name = 'cmdline',
                    option = {
                    ignore_cmds = { 'Man', '!' }
                    }
                }
                })
            })
        end,
    },
    {
        "hrsh7th/cmp-nvim-lua",
        after = "nvim-cmp",
    },
    {
        "chrisgrieser/cmp_yanky",
        after = "nvim-cmp",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "linrongbin16/gitlinker.nvim",
        config = function()
          require('gitlinker').setup()
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
          require('diffview').setup()
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
           { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                        },
                    },
                },
            })
            require("telescope").load_extension("yank_history")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require("telescope").load_extension "frecency"
        end,
        after = "telescope.nvim",
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
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
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
            })
        end,
    },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- require("lspconfig").bashls.setup({})
            -- require("lspconfig").clangd.setup({})
            -- require("lspconfig").cmake.setup({})
            -- require("lspconfig").dockerls.setup({})
            -- require("lspconfig").gopls.setup({})
            -- require("lspconfig").jsonls.setup({})
            -- require("lspconfig").pyright.setup({})
            -- require("lspconfig").rust_analyzer.setup({})
            -- require("lspconfig").terraformls.setup({})
            -- require("lspconfig").yamlls.setup({})
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "yamlls",
                }
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup()
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            -- Set up format-on-save
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
    },
    -- {
    --     "WhoIsSethDaniel/mason-tool-installer.nvim",
    --     config = function()
    --         require("mason-tool-installer").setup()
    --     end,
    -- },
    {
        "j-hui/fidget.nvim",
    },
    -- TODO: go.nvim
}
