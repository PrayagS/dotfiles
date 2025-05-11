return {
	{
		"milanglacier/minuet-ai.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			cmp = { enable_auto_complete = false },
			blink = { enable_auto_complete = true },
			virtualtext = {
				auto_trigger_ft = {},
				keymap = {
					accept = "<A-A>",
					accept_word = "<A-w>",
					accept_line = "<A-a>",
					prev = "<A-[>",
					next = "<A-]>",
					dismiss = "<A-e>",
				},
			},
			provider = "openai_fim_compatible",
			-- notify = "debug",
			provider_options = {
				openai_fim_compatible = {
					api_key = "MINUET_AI_NVIM_DEEPSEEK_API_KEY",
					name = "deepseek",
					optional = {
						max_tokens = 256,
						top_p = 0.9,
					},
				},
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
			duet = {
				provider = "gemini", -- Provider used by `:Minuet duet predict`.
				request_timeout = 15, -- Timeout in seconds for a single duet request.
				editable_region = {
					lines_before = 8, -- Number of editable lines included before the cursor.
					lines_after = 15, -- Number of editable lines included after the cursor.
					before_region_filter_length = 30, -- Trim duplicated text from the start of the model output when it repeats non-editable text before the region.
					after_region_filter_length = 30, -- Trim duplicated text from the end of the model output when it repeats non-editable text after the region.
				},
				non_editable_region = {
					context_window = 40000, -- Maximum characters of non-editable context included around the editable region.
					context_ratio = 0.75, -- Ratio of non-editable context before vs. after the editable region when truncation is needed.
				},
				markers = {
					editable_region_start = "<editable_region>", -- Marker that wraps the start of the editable region in prompts and responses.
					editable_region_end = "</editable_region>", -- Marker that wraps the end of the editable region in prompts and responses.
					cursor_position = "<cursor_position/>", -- Marker the model must preserve exactly once to indicate the final cursor position.
				},
				preview = {
					cursor = "", -- Virtual marker shown at the predicted cursor location in the preview.
				},
				provider_options = {
					gemini = {
						model = "gemini-3-flash-preview",
						optional = {
							generationConfig = {
								thinkingConfig = {
									-- Disable thinking is recommended
									thinkingLevel = "minimal",
								},
							},
						},
						api_key = "MINUET_GEMINI_API_KEY",
					},
				},
			},
		},
	},
}
