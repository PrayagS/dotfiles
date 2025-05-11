vim.lsp.config("gopls", {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			staticcheck = true,
			gofumpt = true,
			codelenses = {
				gc_details = true,
				generate = true,
				regenerate_cgo = true,
				test = true,
				run_govulncheck = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			usePlaceholders = true,
			analyses = {
				shadow = true,
				unusedvariable = true,
				useany = true,
			},
			vulncheck = "Imports",
		},
	},
})
vim.lsp.enable("gopls")
