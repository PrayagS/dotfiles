vim.lsp.config("ruff", {
	init_options = {
		settings = {
			lineLength = 80,
		},
	},
})
vim.lsp.enable("ruff")
