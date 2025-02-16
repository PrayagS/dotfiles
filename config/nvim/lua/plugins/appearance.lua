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
		enabled = false,
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
		dependencies = {
			{ "junegunn/fzf", build = "./install --bin" },
		},
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
			local config = vim.fn["gruvbox_material#get_configuration"]()
			local palette =
				vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
			--[[
			{
				aqua = { "#89b482", "108" },
				bg0 = { "#1d2021", "234" },
				bg0 = { "#282828", "235" },
				bg1 = { "#282828", "235" },
				bg2 = { "#3c3836", "237" },
				bg3 = { "#3c3836", "237" },
				bg4 = { "#504945", "239" },
				bg_current_word = { "#32302f", "236" },
				bg_diff_blue = { "#0d3138", "17" },
				bg_diff_green = { "#32361a", "22" },
				bg_diff_red = { "#3c1f1e", "52" },
				bg_dim = { "#141617", "232" },
				bg_green = { "#a9b665", "142" },
				bg_red = { "#ea6962", "167" },
				bg_statusline1 = { "#282828", "235" },
				bg_statusline2 = { "#32302f", "235" },
				bg_statusline3 = { "#504945", "239" },
				bg_visual_blue = { "#2e3b3b", "17" },
				bg_visual_green = { "#333e34", "22" },
				bg_visual_red = { "#442e2d", "52" },
				bg_visual_yellow = { "#473c29", "94" },
				bg_yellow = { "#d8a657", "214" },
				blue = { "#7daea3", "109" },
				fg0 = { "#d4be98", "223" },
				fg1 = { "#ddc7a1", "223" },
				green = { "#a9b665", "142" },
				grey0 = { "#7c6f64", "243" },
				grey1 = { "#928374", "245" },
				grey2 = { "#a89984", "246" },
				none = { "NONE", "NONE" },
				orange = { "#e78a4e", "208" },
				purple = { "#d3869b", "175" },
				red = { "#ea6962", "167" },
				yellow = { "#d8a657", "214" }
			}

			-- default theme
			normal = {
				a = {bg = palette.grey2[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			insert = {
				a = {bg = palette.bg_green[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			visual = {
				a = {bg = palette.bg_red[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			replace = {
				a = {bg = palette.bg_yellow[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			command = {
				a = {bg = palette.blue[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			terminal = {
				a = {bg = palette.purple[1], fg = palette.bg0[1], gui = 'bold'},
				a = {bg = palette.bg_statusline3[1], fg = palette.fg1[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.fg1[1]}
			},
			inactive = {
				a = {bg = palette.bg_statusline1[1], fg = palette.grey2[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.grey2[1]},
				a = {bg = palette.bg_statusline1[1], fg = palette.grey2[1]}
			}
			--]]

			local updated_gruvbox_material_lualine_theme = {
				normal = {
					a = { bg = palette.bg_statusline2[1], fg = palette.fg1[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline2[1], fg = palette.fg1[1], gui = "bold" },
				},
				insert = {
					a = { bg = palette.bg_green[1], fg = palette.bg0[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.fg1[1] },
				},
				visual = {
					a = { bg = palette.bg_yellow[1], fg = palette.bg0[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.fg1[1] },
				},
				replace = {
					a = { bg = palette.bg_yellow[1], fg = palette.bg0[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.fg1[1] },
				},
				command = {
					a = { bg = palette.blue[1], fg = palette.bg0[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.fg1[1] },
				},
				terminal = {
					a = { bg = palette.purple[1], fg = palette.bg0[1], gui = "bold" },
					b = { bg = palette.bg_statusline3[1], fg = palette.fg1[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.fg1[1] },
				},
				inactive = {
					a = { bg = palette.bg_statusline1[1], fg = palette.grey2[1] },
					b = { bg = palette.bg_statusline1[1], fg = palette.grey2[1] },
					c = { bg = palette.bg_statusline1[1], fg = palette.grey2[1] },
				},
			}

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
				if vim.tbl_get(require("lazy.core.config"), "plugins", "nvim-lint", "_", "loaded") then
					local linters = require("lint").get_running()
					if #linters == 0 then
						return ""
					end
					return string.format("Linters: [%s]", table.concat(linters, ", "))
				else
					return ""
				end
			end

			local get_attached_formatters = function()
				if vim.tbl_get(require("lazy.core.config"), "plugins", "conform.nvim", "_", "loaded") then
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
				else
					return ""
				end
			end

			local diagnostic_icons = {
				["ERROR"] = " ",
				["WARN"] = " ",
				["HINT"] = " ",
				["INFO"] = " ",
			}
			local function get_current_buffer_errors()
				local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity["ERROR"] })
				if count > 0 then
					return string.format("%s%s", diagnostic_icons["ERROR"], count)
				else
					return ""
				end
			end
			local function get_current_buffer_warnings()
				local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity["WARN"] })
				if count > 0 then
					return string.format("%s%s", diagnostic_icons["WARN"], count)
				else
					return ""
				end
			end
			local function get_current_buffer_hints()
				local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity["HINT"] })
				if count > 0 then
					return string.format("%s%s", diagnostic_icons["HINT"], count)
				else
					return ""
				end
			end
			local function get_current_buffer_infotips()
				local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity["INFO"] })
				if count > 0 then
					return string.format("%s%s", diagnostic_icons["INFO"], count)
				else
					return ""
				end
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = updated_gruvbox_material_lualine_theme,
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
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = {
						"mode",
					},
					lualine_b = {
						"branch",
						{
							"diagnostics",
							sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic" },
						},
					},
					lualine_c = {
						"%=",
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = {},
					lualine_y = { "encoding", "filetype", "progress" },
					lualine_z = {
						get_attached_lsp_clients,
						get_attached_linters,
						get_attached_formatters,
						"location",
					},
				},
				tabline = {
					lualine_a = {},
					lualine_b = {
						{
							"buffers",
							buffers_color = {
								active = "lualine_a_replace",
							},
							symbols = {
								alternate_file = "",
							},
						},
					},
					lualine_c = { "" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {
						{
							"tabs",
							tabs_color = {
								active = "lualine_a_replace",
							},
						},
					},
				},
				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {
						{
							"grapple",
							padding = { left = 1, right = 0 },
							separator = { left = "", right = "" },
						},
						{
							get_current_buffer_infotips,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_hints,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_warnings,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_errors,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
					},
					lualine_y = {
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
							-- padding = {
							-- 	left = 0,
							-- 	right = 1,
							-- },
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
					},
					lualine_z = { "filename" },
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {
						{
							"grapple",
							padding = { left = 1, right = 0 },
							separator = { left = "", right = "" },
						},
						{
							get_current_buffer_infotips,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_hints,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_warnings,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
						{
							get_current_buffer_errors,
							color = {
								fg = string.format("%06x", vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg),
							},
							separator = { left = "", right = "" },
							padding = { left = 1, right = 0 },
						},
					},
					lualine_y = {
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
							-- padding = {
							-- 	left = 0,
							-- 	right = 1,
							-- },
							padding = { left = 1, right = 0 },
							separator = { left = "", right = "" },
						},
					},
					lualine_z = { "filename" },
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
			if 1 then
			end

			local modes = { "normal", "insert", "visual", "command", "replace" }
			local diff_types = { "added", "modified", "removed" }

			for _, mode in ipairs(modes) do
				for _, diff_type in ipairs(diff_types) do
					local hl_group = string.format("lualine_a_diff_%s_%s", diff_type, mode)
					local link_group = string.format("lualine_a_diff_%s_inactive", diff_type)
					vim.api.nvim_set_hl(0, hl_group, { link = link_group })
				end
			end
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
		-- cmd = { "TodoTelescope", "TodoQuickFix", "TodoLocList" },
		keys = {
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments()
				end,
			},
		},
		opts = {
			keywords = { "FIX", "FIXME" },
		},
	},
	{
		"stevearc/dressing.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
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
		enabled = false,
		opts = {
			progress = {
				display = {
					done_ttl = 30,
				},
			},
			notification = {
				override_vim_notify = false,
				window = {
					border = "solid",
					align = "top",
				},
			},
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			hide_target_hack = true,
			cursor_color = "none",
		},
	},
	{
		"echasnovski/mini.hipatterns",
		version = false,
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
}
