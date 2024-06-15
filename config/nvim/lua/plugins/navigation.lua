return {
	{
		"ggandor/leap.nvim",
		lazy = false,
		opts = {},
		config = function()
			vim.keymap.set("n", "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")

			require("leap.user").set_repeat_keys("<enter>", "<backspace", {
				relative_directions = true,
			})
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.bracketed").setup({
				yank = { suffix = "", options = {} },
			})
		end,
	},
	{
		"ggandor/flit.nvim",
		lazy = false,
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				labeled_modes = "v",
				multiline = true,
				opts = {},
			})
		end,
	},
	{
		"abecodes/tabout.nvim",
		lazy = false,
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
		opts = {},
	},
	{
		"famiu/bufdelete.nvim",
		keys = {
			{
				"<leader>bd",
				function()
					require("bufdelete").bufdelete()
				end,
				mode = "n",
				desc = "Delete buffer",
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = false,
		init = function()
			require("spider").setup({
				consistentOperatorPending = true,
			})

			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

			-- See: https://github.com/chrisgrieser/nvim-spider#operator-pending-mode-the-case-of-cw
			vim.keymap.set("n", "cw", "ce", { remap = true })
		end,
	},
}
