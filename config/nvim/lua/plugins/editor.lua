return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false,
				ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{
				"<leader>u",
				"<cmd>UndotreeToggle<CR>",
				mode = "n",
				desc = "Toggle Undo Tree",
			},
		},
		opts = {},
	},
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- },
	{
		"gbprod/yanky.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("yanky").setup({
				picker = {
					telescope = {
						use_default_mappings = true,
					},
				},
			})
			local set = vim.keymap.set

			-- Separate keymaps for normal and visual mode to restore
			-- original behavior of p and P in visual mode.
			set({ "n" }, "p", "<Plug>(YankyPutAfter)")
			set({ "n" }, "P", "<Plug>(YankyPutBefore)")

			set({ "x" }, "P", "<Plug>(YankyPutAfter)")
			set({ "x" }, "p", "<Plug>(YankyPutBefore)")

			set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			set("n", "[y", "<Plug>(YankyPreviousEntry)")
			set("n", "]y", "<Plug>(YankyNextEntry)")

			set({ "n", "x" }, "]p", "<Plug>(YankyPutIndentAfterLinewise)")
			set({ "n", "x" }, "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
			set({ "n", "x" }, "]P", "<Plug>(YankyPutIndentAfterLinewise)")
			set({ "n", "x" }, "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

			set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
			set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
			set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
			set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

			set({ "n", "x" }, "=p", "<Plug>(YankyPutAfterFilter)")
			set({ "n", "x" }, "=P", "<Plug>(YankyPutBeforeFilter)")

			require("telescope").load_extension("yank_history")
		end,
	},
	{
		"airblade/vim-rooter",
		-- event = "BufRead",
		lazy = false,
		init = function()
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_resolve_links = 1
			vim.g.rooter_change_directory_for_non_project_files = "current"
		end,
	},
	{
		"lambdalisue/suda.vim",
		cmd = {
			"SudaWrite",
			"SudaRead",
		},
	},
	{
		"nmac427/guess-indent.nvim",
		event = "BufRead",
		config = true,
	},
	{
		"max397574/better-escape.nvim",
		event = "VeryLazy",
		opts = {
			timeout = vim.o.timeoutlen,
			mappings = {
				i = {
					j = {
						-- These can all also be functions
						k = "<Esc>",
					},
				},
				c = {
					j = {
						k = "<Esc>",
					},
				},
				t = {
					j = {
						k = "<Esc>",
					},
				},
				v = {
					j = {
						k = "<Esc>",
					},
				},
				s = {
					j = {
						k = "<Esc>",
					},
				},
			},
		},
	},
}
