return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>ft",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "golines" },
		},
		format_on_save = {
			lsp_format = "first",
		},
	},
}
