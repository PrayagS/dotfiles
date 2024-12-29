return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>q",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
		},
		opts = {
			animate = {
				fps = "120",
			},
			scroll = {
				enabled = true,
				animate = {
					duration = { step = 15, total = 250 },
					fps = "120",
					-- List of easing functions: https://github.com/kikito/tween.lua#easing-functions
					-- Demo: https://easings.net/
					-- To mess with someone, set this to `inOutBounce` or `inOutElastic` ;)
					easing = "inOutExpo",
				},
			},
		},
	},
}
