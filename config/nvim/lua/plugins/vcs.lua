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
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
		opts = {
			explorer = {
				view_mode = "tree",
				position = "bottom",
			},
		},
	},
	{
		"georgeguimaraes/review.nvim",
		dependencies = {
			"esmuellert/codediff.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Review",
		opts = {
			comment_types = {
				note = { key = "n", name = "Note", icon = "📝", hl = "ReviewNote" },
				suggestion = { key = "s", name = "Suggestion", icon = "💡", hl = "ReviewSuggestion" },
				issue = { key = "i", name = "Issue", icon = "⚠️", hl = "ReviewIssue" },
				praise = { key = "p", name = "Praise", icon = "✨", hl = "ReviewPraise" },
			},
			keymaps = {
				add_note = "<leader>dn",
				add_suggestion = "<leader>ds",
				add_issue = "<leader>di",
				add_praise = "<leader>dp",
				delete_comment = "<leader>D",
				edit_comment = "<leader>de",
				next_comment = "]n",
				prev_comment = "[n",
				toggle_file_panel = "f",
			},
			codediff = {
				readonly = true,
			},
		},
	},
}
