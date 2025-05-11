return {
	{
		"nvim-mini/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.bracketed").setup({
				yank = { suffix = "", options = {} },
			})
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		event = "VeryLazy",
		init = function()
			vim.g.miniindentscope_disable = true
		end,
		opts = {
			mappings = {
				-- Textobjects
				object_scope = "ii",
				object_scope_with_border = "ai",
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({})
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"nvim-mini/mini.move",
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
	{
		"nvim-mini/mini.hipatterns",
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
	{
		"nvim-mini/mini.files",
		version = false,
		keys = {
			{
				"<leader>-",
				mode = { "n" },
				":lua MiniFiles.open(vim.api.nvim_buf_get_name(0),true)<cr>",
				desc = "Open at the current file",
			},
			{
				"<leader>f",
				":lua MiniFiles.open(nil, false)<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
		},
		config = function()
			require("mini.files").setup({
				options = {
					permanent_delete = false,
					use_as_default_explorer = false,
				},
				windows = {
					preview = true,
					-- Width of focused window
					width_focus = 40,
					-- Width of non-focused window
					width_nofocus = 20,
					-- Width of preview window
					width_preview = 30,
				},
			})
		end,
	},
	{
		"nvim-mini/mini.comment",
		version = false,
		event = "VeryLazy",
		opts = {},
	},
}
