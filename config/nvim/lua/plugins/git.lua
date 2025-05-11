return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			current_line_blame = true,
			culhl = true,
			numhl = true,
			linehl = false,
			-- word_diff = true,
			diff_opts = {
				algorithm = "histogram",
				internal = true,
				indent_heuristic = true,
				linematch = 60,
				vertical = true,
			},
			on_attach = function(bufnr)
				-- TODO: Telescope keymaps for gitsigns. Refer get_actions() /
				-- get_hunks()
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", '<cmd>lua require("gitsigns").nav_hunk("next")<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", '<cmd>lua require("gitsigns").nav_hunk("prev")<CR>', {})
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hS",
					'<cmd>lua require("gitsigns").stage_buffer()<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hs",
					'<cmd>lua require("gitsigns").stage_hunk()<cr>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hu",
					'<cmd>lua require("gitsigns").undo_stage_hunk()<cr>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"x",
					"<leader>hu",
					'<cmd>lua require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"x",
					"<leader>hs",
					'<cmd>lua require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hR",
					'<cmd>lua require("gitsigns").reset_buffer()<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hr",
					'<cmd>lua require("gitsigns").reset_hunk()<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"x",
					"<leader>hr",
					'<cmd>lua require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<leader>hp",
					'<cmd>lua require("gitsigns").preview_hunk_inline()<CR>',
					{}
				)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hd", '<cmd>lua require("gitsigns").diffthis()<CR>', {})
			end,
		},
	},
	{
		"linrongbin16/gitlinker.nvim",
		opts = {},
		keys = {
			{
				"<leader>ghL",
				"<cmd>lua require('gitlinker').link({ action = require('gitlinker.actions').system })<cr>",
				mode = { "n", "v" },
				desc = "GitLink!",
			},
			{
				"<leader>ghB",
				"<cmd>lua require('gitlinker').link({ router_type = 'blame', action = require('gitlinker.actions').system })<cr>",
				mode = { "n", "v" },
				desc = "GitLink! blame",
			},
			{
				"<leader>ghD",
				"<cmd>lua require('gitlinker').link({ router_type = 'default_branch', action = require('gitlinker.actions').system })<cr>",
				mode = { "n", "v" },
				desc = "GitLink! default_branch",
			},
			{
				"<leader>ghC",
				"<cmd>lua require('gitlinker').link({ router_type = 'current_branch', action = require('gitlinker.actions').system })<cr>",
				mode = { "n", "v" },
				desc = "GitLink! current_branch",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		enabled = false,
		opts = {},
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
			"DiffviewLog",
		},
	},
	{
		"kdheepak/lazygit.nvim",
		enabled = false,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"pwntester/octo.nvim",
		enabled = false,
		cmd = {
			"Octo",
		},
		opts = {
			enable_builtin = true,
		},
	},
	{
		"julienvincent/hunk.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cmd = { "DiffEditor" },
		opts = {},
	},
	{
		"rafikdraoui/jj-diffconflicts",
		cmd = { "JJDiffConflicts" },
	},
}
