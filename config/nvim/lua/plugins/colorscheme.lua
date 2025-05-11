return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		init = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_ui_contrast = "high"
			vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
			vim.g.gruvbox_material_current_word = "high contrast background"

			--  Override highlight groups
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
				pattern = "gruvbox-material",
				callback = function()
					local config = vim.fn["gruvbox_material#get_configuration"]()
					local palette = vim.fn["gruvbox_material#get_palette"](
						config.background,
						config.foreground,
						config.colors_override
					)
					local set_hl = vim.fn["gruvbox_material#highlight"]

					set_hl("IblScope", palette.green, palette.none)
					set_hl("SnacksIndentScope", palette.yellow, palette.none)
					set_hl("ColorfulWinSep", palette.yellow, palette.none)
					vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
					vim.api.nvim_set_hl(0, "LeapMatch", { link = "TSNote" })
					vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "TSNote" })
					vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Grey" })
				end,
			})

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	-- {
	-- 	"sainnhe/sonokai",
	-- 	config = function()
	-- 		vim.g.sonokai_style = "espresso"
	-- 		vim.g.sonokai_transparent_background = 1
	-- 		vim.g.sonokai_disable_italic_comment = 1
	-- 		vim.g.sonokai_diagnostic_virtual_text = "highlighted"
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("sonokai")
	-- 	end,
	-- },
	-- {
	-- 	"sainnhe/everforest",
	-- 	config = function()
	-- 		vim.g.everforest_transparent_background = 1
	-- 		vim.g.everforest_disable_italic_comment = 1
	-- 		vim.g.everforest_background = "hard"
	-- 		vim.g.everforest_ui_contrast = "high"
	-- 		vim.g.everforest_diagnostic_virtual_text = "highlighted"
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },
	-- {
	-- 	"savq/melange-nvim",
	-- 	config = function()
	-- 		require("transparent").setup({})
	-- 		require("transparent").toggle(true)
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd("colorscheme melange")
	-- 	end,
	-- },
	-- {
	-- 	"yorik1984/newpaper.nvim",
	-- 	config = function()
	-- 		require("newpaper").setup({
	-- 			style = "light",
	-- 			lualine_style = "light",
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"maxmx03/solarized.nvim",
	-- 	config = function()
	-- 		require("solarized").setup({
	-- 			transparent = { enabled = true },
	-- 			variant = "winter",
	-- 		})
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd("colorscheme solarized")
	-- 	end,
	-- },
	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	config = function()
	-- 		require("vscode").setup({
	-- 			transparent = true,
	-- 		})
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd("colorscheme vscode")
	-- 	end,
	-- },
	-- {
	-- 	"miikanissi/modus-themes.nvim",
	-- 	config = function()
	-- 		require("modus-themes").setup({
	-- 			variant = "tinted",
	-- 			transparent = true,
	-- 		})
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd("colorscheme modus")
	-- 	end,
	-- },
	-- {
	-- 	"NTBBloodbath/doom-one.nvim",
	-- 	init = function()
	-- 		vim.cmd("colorscheme doom-one")
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	opts = {
	-- 		flavour = "mocha", -- latte, frappe, macchiato, mocha
	-- 		transparent_background = true, -- disables setting the background color.
	-- 		default_integrations = true,
	-- 		integrations = {
	-- 			cmp = true,
	-- 			gitsigns = true,
	-- 			nvimtree = true,
	-- 			which_key = true,
	-- 			treesitter = true,
	-- 			treesitter_context = true,
	-- 			diffview = true,
	-- 			leap = true,
	-- 			telescope = {
	-- 				enabled = true,
	-- 				-- style = "nvchad"
	-- 			},
	-- 			indent_blankline = {
	-- 				enabled = true,
	-- 				scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
	-- 				colored_indent_levels = true,
	-- 			},
	-- 			mason = true,
	-- 			native_lsp = {
	-- 				enabled = true,
	-- 				virtual_text = {
	-- 					errors = { "italic" },
	-- 					hints = { "italic" },
	-- 					warnings = { "italic" },
	-- 					information = { "italic" },
	-- 					ok = { "italic" },
	-- 				},
	-- 				underlines = {
	-- 					errors = { "underline" },
	-- 					hints = { "underline" },
	-- 					warnings = { "underline" },
	-- 					information = { "underline" },
	-- 					ok = { "underline" },
	-- 				},
	-- 				inlay_hints = {
	-- 					background = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },
}
