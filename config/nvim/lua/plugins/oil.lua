return {
	"stevearc/oil.nvim",
	keys = {
		{
			"-",
			"<CMD>Oil<CR>",
			mode = { "n" },
			desc = "Open parent directory",
		},
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			experimental_watch_for_changes = true,
			keymaps = {
				["gl"] = function()
					require("oil").set_columns({ "mtime", "size", "icon" })
				end,
				["gL"] = function()
					require("oil").set_columns({ "icon" })
				end,
			},
			view_options = {
				show_hidden = true,
			},
			float = {
				win_options = {
					winblend = 10,
				},
			},
		})
	end,
}
