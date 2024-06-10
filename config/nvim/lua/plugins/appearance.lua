return {
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
					},
				},
			},
		},
		-- Separate function to load as we require catppuccin to configure highlights
		config = function(_, opts)
			-- Maintain a map of highlights from different themes
			-- local highlights_from_theme = {}
			-- highlights_from_theme["catppuccin-mocha"] = require("catppuccin.groups.integrations.bufferline").get()

			require("bufferline").setup({
				options = opts.options,
				-- highlights = highlights_from_theme[vim.cmd("silent colorscheme")] or {},
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
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()
			local kopts = { noremap = false, silent = true }
			-- Not setting n and N as they're being set by cinnamon
			-- vim.api.nvim_set_keymap('n', 'n',
			--     [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			--     kopts)
			-- vim.api.nvim_set_keymap('n', 'N',
			--     [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			--     kopts)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
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
	{ "m4xshen/smartcolumn.nvim", opts = {} },
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
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup({
				extra_keymaps = true,
				extended_keymaps = true,
				hide_cursor = true,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Maintain a map of lualine themes
			local themes = {}
			themes["gruvbox-material"] = "gruvbox-material"
			themes["sonokai"] = "sonokai"
			themes["everforest"] = "everforest"
			themes["catppuccin-mocha"] = "catppuccin"

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = themes[vim.cmd("silent colorscheme")] or "auto",
					component_separators = "",
					section_separators = "",
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {
						"branch",
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
						"diagnostics",
					},
					lualine_c = {
						"%=",
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {
					"lazy",
					"nvim-tree",
					"quickfix",
				},
			})
		end,
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
		config = function(_, opts)
			require("live-command").setup(opts)
		end,
	},
	{
		"jiriks74/presence.nvim",
		name = "presence",
		event = "UIEnter",
		opts = {
			neovim_image_text = "The One True Text Editor",
			debounce_timeout = 60,
			-- enable_line_number = true,
		},
	},
	{
		"yamatsum/nvim-cursorline",
		event = "VeryLazy",
		opts = {
			cursorword = {
				enable = false,
			},
			cursorline = {
				enable = true,
				number = true,
				timeout = 250,
			},
		},
	},
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"tris203/precognition.nvim",
		event = "VeryLazy",
		opts = {
			startVisible = true,
		},
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>?", '<cmd>lua require("precognition").peek()<CR>', {})
		end,
	},
}
