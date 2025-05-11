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
					accept = "<A-A>",
					accept_line = "<A-a>",
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
					model = "gemini-2.5-flash-lite-preview-06-17",
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
	{
		"coder/claudecode.nvim",
		keys = {
			-- { "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			-- { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			-- {
			-- 	"<leader>as",
			-- 	"<cmd>ClaudeCodeTreeAdd<cr>",
			-- 	desc = "Add file",
			-- 	ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
			-- },
			-- Diff management
			{ "<leader>cy", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>cn", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
		opts = {
			focus_after_send = true,
			terminal = {
				split_side = "left",
				provider = "native",
			},
		},
	},
}
