return {
	{
		"ggandor/leap.nvim",
		enabled = false,
		lazy = false,
		opts = {},
		config = function()
			vim.keymap.set("n", "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "o" }, "gs", function()
				require("leap.remote").action()
			end)
			-- Source: leap.nvim README
			vim.keymap.set({ "n", "x", "o" }, "ga", function()
				local sk = vim.deepcopy(require("leap").opts.special_keys)
				-- If you just want to overwrite the keys, and only use a/A:
				sk.next_target = "a"
				sk.prev_target = "A"
				-- If you want to add them as extra keys, keep in mind that the items
				-- in `special_keys` can be both strings or tables (the shortest
				-- workaround might be the below one):
				sk.next_target = vim.fn.flatten(vim.list_extend({ "a" }, { sk.next_target }))
				sk.prev_target = vim.fn.flatten(vim.list_extend({ "A" }, { sk.prev_target }))

				require("leap.treesitter").select({ opts = { special_keys = sk } })
			end)

			require("leap.user").set_repeat_keys("<enter>", "<backspace>", {
				relative_directions = true,
			})
		end,
	},
	{
		"ggandor/flit.nvim",
		enabled = false,
		dependencies = {
			"ggandor/leap.nvim",
		},
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
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
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
				"<c-s>",
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
}
