return {
	"stevearc/oil.nvim",
	lazy = false,
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
			watch_for_changes = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
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

		vim.keymap.set("n", "<leader>f", function()
			require("oil").open_float()
		end)
	end,
}
