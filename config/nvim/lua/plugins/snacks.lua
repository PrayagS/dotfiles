return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
		},
		opts = {},
	},
}
