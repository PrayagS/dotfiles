return {
	{
		"abecodes/tabout.nvim",
		lazy = false,
		opts = {},
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
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-f>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = function()
			require("flash").setup({
				label = {
					rainbow = { enabled = true },
				},
				modes = {
					char = { enabled = true },
					search = { enabled = false },
					treesitter = {
						label = {
							style = "inline",
						},
					},
				},
			})

			-- jump to treesitter node
			vim.keymap.set({ "n", "o", "x" }, "<leader>jt", function()
				require("flash").treesitter({
					jump = {
						pos = "start",
					},
				})
			end)

			-- select treesitter node
			vim.keymap.set({ "n", "o", "x" }, "<leader>vt", function()
				require("flash").treesitter({
					jump = {
						pos = "range",
					},
				})
			end)
		end,
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		cmd = "Grapple",
		keys = {
			{ "<leader>;", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			{ "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
			{ "]g", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
			{ "[g", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
		},
		opts = {
			scope = "git_branch",
		},
	},
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		init = function()
			require("smart-splits").setup({
				cursor_follows_swapped_bufs = true,
			})
			vim.keymap.set("n", "<leader>H", require("smart-splits").resize_left)
			vim.keymap.set("n", "<leader>J", require("smart-splits").resize_down)
			vim.keymap.set("n", "<leader>K", require("smart-splits").resize_up)
			vim.keymap.set("n", "<leader>L", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
			vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
			-- swapping buffers between windows
			vim.keymap.set("n", "<leader>sh", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader>sj", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader>sk", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader>sl", require("smart-splits").swap_buf_right)
		end,
	},
}
