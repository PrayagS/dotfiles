vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			format = {
				enable = true,
				singleQuote = true,
				bracketSpacing = true,
			},
			validate = true,
			hover = true,
			completion = true,
		},
	},
})
vim.lsp.enable("yamlls")
