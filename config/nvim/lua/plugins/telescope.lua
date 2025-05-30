return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		-- event = "VeryLazy",
		-- cmd = { "Telescope" },
		-- keys = {
		-- 	{
		-- 		"<leader><leader>",
		-- 		function()
		-- 			require("telescope").extensions.smart_open.smart_open()
		-- 		end,
		-- 		desc = ":Telescope smart_open",
		-- 	},
		-- 	{
		-- 		"<C-p>",
		-- 		function()
		-- 			require("telescope.builtin").git_files()
		-- 		end,
		-- 		desc = ":Telescope git_files",
		-- 	},
		-- 	{
		-- 		"<C-S-p>",
		-- 		function()
		-- 			require("telescope").extensions.frecency.frecency()
		-- 		end,
		-- 		desc = ":Telescope frecency",
		-- 	},
		-- 	{
		-- 		"<leader>p",
		-- 		function()
		-- 			require("telescope.builtin").find_files()
		-- 		end,
		-- 		desc = ":Telescope find_files",
		-- 	},
		-- 	{
		-- 		"<leader>g",
		-- 		function()
		-- 			require("telescope").extensions.live_grep_args.live_grep_args()
		-- 		end,
		-- 		desc = ":Telescope live_grep_args",
		-- 	},
		-- 	{
		-- 		"<leader>G",
		-- 		desc = ":Telescope live_grep_args current buffer",
		-- 	},
		-- 	{
		-- 		"<leader>w",
		-- 		function()
		-- 			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
		-- 		end,
		-- 		desc = ":Telescope grep_word_under_cursor",
		-- 	},
		-- 	{
		-- 		"<leader>W",
		-- 		function()
		-- 			require("telescope-live-grep-args.shortcuts").grep_word_under_cursor_current_buffer()
		-- 		end,
		-- 		desc = ":Telescope grep_word_under_cursor_current_buffer",
		-- 	},
		-- 	{
		-- 		"<leader>g",
		-- 		function()
		-- 			require("telescope-live-grep-args.shortcuts").grep_visual_selection()
		-- 		end,
		-- 		mode = { "v" },
		-- 		desc = ":Telescope grep_visual_selection",
		-- 	},
		-- 	{
		-- 		"<leader>G",
		-- 		function()
		-- 			require("telescope-live-grep-args.shortcuts").grep_word_visual_selection_current_buffer()
		-- 		end,
		-- 		mode = { "v" },
		-- 		desc = ":Telescope grep_word_visual_selection_current_buffer",
		-- 	},
		-- 	{
		-- 		"<leader>ht",
		-- 		function()
		-- 			require("telescope.builtin").help_tags()
		-- 		end,
		-- 		desc = ":Telescope help_tags",
		-- 	},
		-- 	{
		-- 		"<leader>km",
		-- 		function()
		-- 			require("telescope.builtin").keymaps()
		-- 		end,
		-- 		desc = ":Telescope keymaps",
		-- 	},
		-- 	{
		-- 		"gd",
		-- 		function()
		-- 			require("telescope.builtin").lsp_definitions()
		-- 		end,
		-- 		desc = "[G]oto [D]efinition",
		-- 	},
		-- 	{
		-- 		"gr",
		-- 		function()
		-- 			require("telescope.builtin").lsp_references()
		-- 		end,
		-- 		desc = "[G]oto [R]eferences",
		-- 	},
		-- 	{
		-- 		"gI",
		-- 		function()
		-- 			require("telescope.builtin").lsp_implementations()
		-- 		end,
		-- 		desc = "[G]oto [I]mplementation",
		-- 	},
		-- 	{
		-- 		"<leader>D",
		-- 		function()
		-- 			require("telescope.builtin").lsp_type_definitions()
		-- 		end,
		-- 		desc = "Type [D]efinition",
		-- 	},
		-- 	{
		-- 		"<leader>ds",
		-- 		function()
		-- 			require("telescope.builtin").lsp_document_symbols()
		-- 		end,
		-- 		desc = "[D]ocument [S]ymbols",
		-- 	},
		-- 	{
		-- 		"<leader>ws",
		-- 		function()
		-- 			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		-- 		end,
		-- 		desc = "[W]orkspace [S]ymbols",
		-- 	},
		-- 	{
		-- 		"<leader>yh",
		-- 		function()
		-- 			require("telescope").extensions.yank_history.yank_history()
		-- 		end,
		-- 		desc = ":Telescope yank_history",
		-- 	},
		-- },
		-- dependencies = {
		-- 	"nvim-lua/plenary.nvim",
		-- 	"nvim-telescope/telescope-live-grep-args.nvim",
		-- 	{
		-- 		"nvim-telescope/telescope-fzf-native.nvim",
		-- 		build = "make",
		-- 	},
		-- 	"nvim-telescope/telescope-frecency.nvim",
		-- 	"danielfalk/smart-open.nvim",
		-- 	"kkharji/sqlite.lua",
		-- 	"nvim-telescope/telescope-ui-select.nvim",
		-- },
		config = function()
			-- local lga_actions = require("telescope-live-grep-args.actions")

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
					help_tags = { theme = "ivy" },
					keymaps = { theme = "ivy" },
				},
				-- extensions = {
				-- 	live_grep_args = {
				-- 		auto_quoting = false,
				-- 		mappings = { -- extend mappings
				-- 			i = {
				-- 				["<C-k>"] = lga_actions.quote_prompt(),
				-- 				["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				-- 			},
				-- 		},
				-- 		theme = "ivy",
				-- 	},
				-- 	frecency = {
				-- 		db_safe_mode = false,
				-- 		db_validate_threshold = 100,
				-- 		default_workspace = "CWD",
				-- 		enable_prompt_mappings = true,
				-- 		hide_current_buffer = true,
				-- 		matcher = "fuzzy",
				-- 		max_timestamps = 100,
				-- 		preceding = "opened",
				-- 	},
				-- 	smart_open = {
				-- 		cwd_only = true,
				-- 		match_algorithm = "fzf",
				-- 	},
				-- 	fzf = {
				-- 		fuzzy = true,
				-- 		override_generic_sorter = true,
				-- 		override_file_sorter = true,
				-- 	},
				-- },
			})
			-- require("telescope").load_extension("live_grep_args")
			-- require("telescope").load_extension("frecency")
			-- require("telescope").load_extension("smart_open")
			-- require("telescope").load_extension("fzf")
			-- require("telescope").load_extension("ui-select")
			-- require("telescope").load_extension("aerial")
			-- require("telescope").load_extension("session-lens")
			-- require("telescope").load_extension("yank_history")

			-- local Path = require("plenary.path")
			-- local get_open_files = function()
			-- 	local open_files = {}
			-- 	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			-- 		if vim.fn.buflisted(bufnr) == 1 then
			-- 			table.insert(open_files, Path:new(vim.api.nvim_buf_get_name(bufnr)):make_relative(vim.uv.cwd()))
			-- 		end
			-- 	end
			-- 	return open_files
			-- end
			-- local live_grep_open_files = function()
			-- 	local open_file_list = get_open_files()
			-- 	require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = open_file_list })
			-- end

			-- vim.keymap.set("n", "<leader>g", builtin.current_buffer_fuzzy_find, {})
			-- vim.keymap.set("n", "<leader>G", live_grep_open_files, {})
		end,
	},
}
