return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-frecency.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local lga_actions = require("telescope-live-grep-args.actions")

			-- Add additional rg args
			local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			table.insert(vimgrep_arguments, "--follow")

			require("telescope").setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					path_display = {
						"smart",
					},
					dynamic_preview_title = true,
					selection_caret = " ",
					multi_icon = " ",
					layout_config = {
						prompt_position = "top",
					},
				},
				pickers = {
					grep_string = {
						use_regex = true,
					},
					find_files = {
						follow = true,
						hidden = true,
					},
					help_tags = { theme = "ivy" },
					keymaps = { theme = "ivy" },
				},
				extensions = {
					live_grep_args = {
						auto_quoting = false,
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},
						theme = "ivy",
					},
					frecency = {
						db_safe_mode = false,
						db_validate_threshold = 100,
						matcher = "fuzzy",
						max_timestamps = 100,
						preceding = "opened",
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			})
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("frecency")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("aerial")
			require("telescope").load_extension("session-lens")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", function()
				require("telescope").extensions.frecency.frecency({})
			end)
			vim.keymap.set("n", "<leader>p", builtin.find_files, {})
			vim.keymap.set("n", "<C-S-p>", builtin.git_files, {})

			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

			local Path = require("plenary.path")
			local get_open_files = function()
				local open_files = {}
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if vim.fn.buflisted(bufnr) == 1 then
						table.insert(open_files, Path:new(vim.api.nvim_buf_get_name(bufnr)):make_relative(vim.uv.cwd()))
					end
				end
				return open_files
			end
			local live_grep_open_files = function()
				local open_file_list = get_open_files()
				require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = open_file_list })
			end

			-- vim.keymap.set("n", "<leader>g", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set(
				"n",
				"<leader>g",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{}
			)
			vim.keymap.set("n", "<leader>G", live_grep_open_files, {})

			vim.keymap.set("n", "<leader>w", live_grep_args_shortcuts.grep_word_under_cursor, {})
			vim.keymap.set("n", "<leader>W", live_grep_args_shortcuts.grep_word_under_cursor_current_buffer, {})

			vim.keymap.set("v", "<leader>g", live_grep_args_shortcuts.grep_visual_selection, {})
			vim.keymap.set("v", "<leader>G", live_grep_args_shortcuts.grep_word_visual_selection_current_buffer, {})

			vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
		end,
	},
}
