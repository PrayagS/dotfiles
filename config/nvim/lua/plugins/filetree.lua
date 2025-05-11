return {
	{
		"mikavilpas/yazi.nvim",
		enabled = false,
		keys = {
			{
				"<leader>-",
				mode = { "n", "v" },
				":lua MiniFiles.open(vim.api.nvim_buf_get_name(0),true)<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
}
