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
}
