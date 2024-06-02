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
		-- Source: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#autoformat-with-extra-features
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { lsp_fallback = true }
		end,
	},
}
