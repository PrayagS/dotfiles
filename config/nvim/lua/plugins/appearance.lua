return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 100
		end,
		opts = {
			preset = "helix",
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
				always_show_bufferline = false,
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
		enabled = false,
		main = "ibl",
		opts = {},
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()
			local kopts = { noremap = false, silent = true }
			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
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
				border = "solid",
				winblend = 0,
			},
		},
	},
	{ "m4xshen/smartcolumn.nvim", opts = {} },
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
			themes["newpaper"] = "newpaper"
			themes["solarized"] = "solarized"
			themes["vscode"] = "vscode"
			themes["modus"] = "modus"
			themes["catppuccin-mocha"] = "catppuccin"

			local function get_attached_lsp_clients()
				local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
				if #buf_clients == 0 then
					return "LSP Inactive"
				end
				local buf_client_names = {}
				for _, client in pairs(buf_clients) do
					table.insert(buf_client_names, client.name)
				end
				local client_names_str = table.concat(buf_client_names, ", ")
				if #client_names_str == 0 then
					return ""
				end
				local language_servers = string.format("LSP: [%s]", client_names_str)
				return language_servers
			end

			local get_attached_linters = function()
				local linters = require("lint").get_running()
				if #linters == 0 then
					return ""
				end
				return string.format("Linters: [%s]", table.concat(linters, ", "))
			end

			local get_attached_formatters = function()
				local formatters, using_lsp_formatter = require("conform").list_formatters_to_run(0)
				local formatter_names = {}
				for _, formatter in pairs(formatters) do
					table.insert(formatter_names, formatter.name)
				end
				if using_lsp_formatter then
					table.insert(formatter_names, "LSP")
				end
				if #formatter_names == 0 then
					return ""
				end
				return string.format("Formatters: [%s]", table.concat(formatter_names, ", "))
			end

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
						{
							"diagnostics",
							sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic" },
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						get_attached_lsp_clients,
						get_attached_linters,
						get_attached_formatters,
						"location",
					},
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
		cmd = "Preview",
		opts = {
			enable_highlighting = true,
			inline_highlighting = true,
			hl_groups = {
				insertion = "DiffAdd",
				deletion = "DiffDelete",
				change = "DiffChange",
			},
			commands = {
				Norm = { cmd = "norm" },
				G = { cmd = "g" },
				D = { cmd = "d" },
			},
		},
		config = function(_, opts)
			require("live-command").setup(opts)
		end,
	},
	{
		"jiriks74/presence.nvim",
		enabled = false,
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
		"MagicDuck/grug-far.nvim",
		keys = {
			{
				"<leader>rg",
				"<cmd>GrugFar<cr>",
				mode = { "n", "v" },
				desc = "GrugFar",
			},
		},
		config = function()
			require("grug-far").setup({
				engines = {
					ripgrep = {
						extraRgArgs = "--smart-case --follow --hidden --threads=32 --context=3 --heading --line-number",
					},
				},
				transient = true,
			})
		end,
	},
	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>sr",
				"<cmd>lua require('ssr').open()<cr>",
				mode = { "n", "x" },
				desc = "structured search and replace (ssr)",
			},
		},
		config = function()
			require("ssr").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTelescope", "TodoQuickFix", "TodoLocList" },
		opts = {},
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = false,
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { " ", builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
						},
					})
				end,
			},
		},
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

			require("ufo").setup()
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		opts = {
			hi = {
				bg = "#1d2021",
				fg = "#d4be98",
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					done_ttl = 30,
				},
			},
			notification = {
				override_vim_notify = true,
				window = {
					x_padding = 2,
					y_padding = 1,
					border = "solid",
					align = "top",
				},
			},
		},
	},
}
