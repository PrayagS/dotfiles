return {
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.bracketed").setup({
				yank = { suffix = "", options = {} },
			})
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"echasnovski/mini.move",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "H",
					right = "L",
					down = "J",
					up = "K",

					-- Move current line in Normal mode
					line_left = "H",
					line_right = "L",
					line_down = "J",
					line_up = "K",
				},
			})
		end,
	},
}
