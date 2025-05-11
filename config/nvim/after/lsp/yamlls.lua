return {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
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
}
