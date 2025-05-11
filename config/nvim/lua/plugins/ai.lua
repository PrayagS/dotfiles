return {
	{
		"milanglacier/minuet-ai.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			cmp = { enable_auto_complete = false },
			blink = { enable_auto_complete = true },
			provider = "gemini",
			-- notify = "debug",
			provider_options = {
				codestral = {
					model = "codestral-latest",
					end_point = "https://codestral.mistral.ai/v1/fim/completions",
					api_key = "CODESTRAL_API_KEY",
					stream = true,
				},
				gemini = {
					model = "gemini-2.5-flash-lite",
					api_key = "MINUET_GEMINI_API_KEY",
					stream = true,
					optional = {
						-- Ref: https://ai.google.dev/api/generate-content#v1beta.GenerationConfig
						generationConfig = {
							temperature = 0.0,
							topP = 0.9,
						},
					},
				},
			},
		},
	},
}
