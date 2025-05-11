vim.lsp.config("tinymist", {
	settings = {
		exportPdf = "onSave",
		formatterMode = "typstyle",
	},
})
vim.lsp.enable("tinymist")
