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
	{
		"coder/claudecode.nvim",
		event = "VeryLazy",
		keys = {
			-- { "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			-- { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			-- Diff management
			{ "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
		opts = {
			focus_after_send = true,
			terminal = {
				provider = "none",
			},
		},
	},
}
