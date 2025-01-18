return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
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
			cue = { "cue_fmt" },
			zsh = { "shfmt" },
		},
		format_on_save = {
			lsp_format = "first",
		},
	},
}
