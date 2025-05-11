vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			completion = {
				displayContext = 5,
			},
			diagnostics = {
				globals = { "vim", "Snacks" },
			},
			hint = {
				enable = true,
				setType = true,
			},
			codeLens = { enable = true },
		},
	},
})
vim.lsp.enable("lua_ls")
