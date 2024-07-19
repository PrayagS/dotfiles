return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-frecency.nvim",
		},
		opts = {
			defaults = {
				path_display = {
					"smart",
				},
				dynamic_preview_title = true,
				selection_caret = " ",
				multi_icon = " ",
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},
			pickers = {
				grep_string = {
					use_regex = true,
				},
				find_files = {
					follow = true,
					hidden = true,
				},
			},
			extensions = {
				live_grep_args = {
					auto_quoting = false,
				},
				frecency = {
					db_safe_mode = false,
					db_validate_threshold = 100,
					matcher = "fuzzy",
					max_timestamps = 100,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("frecency")
			-- require("telescope").load_extension("session-lens")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>p", builtin.find_files, {})
			vim.keymap.set("n", "<C-S-p>", function()
				require("telescope").extensions.frecency.frecency({})
			end)

			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

			-- vim.keymap.set("n", "<leader>g", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set(
				"n",
				"<leader>g",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ grep_open_files = true })<CR>",
				{}
			)
			vim.keymap.set(
				"n",
				"<leader>G",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{}
			)
			vim.keymap.set("n", "<leader>gw", live_grep_args_shortcuts.grep_word_under_cursor, {})

			-- Source: https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431
			function vim.getVisualSelection()
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})

				text = string.gsub(text, "\n", "")
				if #text > 0 then
					return text
				else
					return ""
				end
			end

			-- This is until live_grep_args supports passing options to grep_visual_selection.
			-- See https://github.com/nvim-telescope/telescope-live-grep-args.nvim/issues/78
			vim.keymap.set("v", "<leader>g", function()
				local text = vim.getVisualSelection()
				builtin.current_buffer_fuzzy_find({ default_text = text })
			end, {})
			vim.keymap.set("v", "<leader>G", live_grep_args_shortcuts.grep_visual_selection, {})

			-- vim.keymap.set("v", "<leader>G", function()
			-- 	local text = vim.getVisualSelection()
			-- 	builtin.live_grep({ default_text = text })
			-- end, {})

			vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
		end,
	},
}
