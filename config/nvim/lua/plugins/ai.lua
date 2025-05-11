return {
	{
		"ggml-org/llama.vim",
		enabled = false,
		event = "VeryLazy",
		init = function()
			vim.g.llama_config = {
				show_info = 0,
			}
		end,
	},
	{
		"milanglacier/minuet-ai.nvim",
		event = "VeryLazy",
		opts = {
			cmp = { enable_auto_complete = false },
			blink = { enable_auto_complete = true },
			virtualtext = {
				auto_trigger_ft = { "*" },
				keymap = {
					accept = "<C-A>",
					accept_line = "<C-a>",
					prev = "<C-p>",
					next = "<C-n>",
					dismiss = "<C-e>",
				},
			},
			provider = "codestral",
			-- notify = "debug",
			provider_options = {
				codestral = {
					model = "codestral-latest",
					end_point = "https://codestral.mistral.ai/v1/fim/completions",
					api_key = "CODESTRAL_API_KEY",
					stream = true,
				},
				gemini = {
					model = "gemini-2.5-flash-preview-04-17",
					api_key = "MINUET_GEMINI_API_KEY",
					stream = true,
					optional = {
						generationConfig = {
							thinkingConfig = {
								thinkingBudget = 0,
							},
						},
					},
				},
			},
		},
	},
}
