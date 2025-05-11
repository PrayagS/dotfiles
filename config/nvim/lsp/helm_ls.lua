vim.lsp.config("helm_ls", {
	settings = {
		["helm-ls"] = {
			yamlls = {
				enabled = false,
			},
		},
	},
})
vim.lsp.enable("helm_ls")
