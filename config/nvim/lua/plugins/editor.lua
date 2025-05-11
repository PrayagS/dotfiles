return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				enable_check_bracket_line = false,
				ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
				map_c_w = true,
				map_bs = false,
				disable_in_visualblock = true,
			})
			-- Ref: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#insertion-with-surrounding-check
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			function Insertion_with_surrounding_check(a1, ins, a2, lang)
				npairs.add_rule(Rule(ins, ins, lang)
					:with_pair(function(opts)
						return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
					:with_del(function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
					end))
			end

			Insertion_with_surrounding_check("{", " ", "}")
			Insertion_with_surrounding_check("(", " ", ")")
			Insertion_with_surrounding_check("[", " ", "]")
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
	{
		"gbprod/yanky.nvim",
		dependencies = {
			{ "kkharji/sqlite.lua" },
			{ "folke/snacks.nvim" },
		},
		-- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		keys = {
			{
				"y",
				"<Plug>(YankyYank)",
				mode = { "n", "x" },
				desc = "Yank text",
			},
			{
				"p",
				"<Plug>(YankyPutAfter)",
				mode = { "n", "x" },
				desc = "Put yanked text after cursor",
			},
			{
				"P",
				"<Plug>(YankyPutBefore)",
				mode = { "n", "x" },
				desc = "Put yanked text before cursor",
			},
			{
				"gp",
				"<Plug>(YankyGPutAfter)",
				mode = { "n", "x" },
				desc = "Put yanked text after selection",
			},
			{
				"gP",
				"<Plug>(YankyGPutBefore)",
				mode = { "n", "x" },
				desc = "Put yanked text before selection",
			},
			{
				"[y",
				"<Plug>(YankyPreviousEntry)",
				desc = "Select previous entry through yank history",
			},
			{
				"]y",
				"<Plug>(YankyNextEntry)",
				desc = "Select next entry through yank history",
			},
			{
				"]p",
				"<Plug>(YankyPutIndentAfterLinewise)",
				desc = "Put indented after cursor (linewise)",
			},
			{
				"[p",
				"<Plug>(YankyPutIndentBeforeLinewise)",
				desc = "Put indented before cursor (linewise)",
			},
			{
				"]P",
				"<Plug>(YankyPutIndentAfterLinewise)",
				desc = "Put indented after cursor (linewise)",
			},
			{
				"[P",
				"<Plug>(YankyPutIndentBeforeLinewise)",
				desc = "Put indented before cursor (linewise)",
			},
			{
				">p",
				"<Plug>(YankyPutIndentAfterShiftRight)",
				desc = "Put and indent right",
			},
			{
				"<p",
				"<Plug>(YankyPutIndentAfterShiftLeft)",
				desc = "Put and indent left",
			},
			{
				">P",
				"<Plug>(YankyPutIndentBeforeShiftRight)",
				desc = "Put before and indent right",
			},
			{
				"<P",
				"<Plug>(YankyPutIndentBeforeShiftLeft)",
				desc = "Put before and indent left",
			},
			{
				"=p",
				"<Plug>(YankyPutAfterFilter)",
				desc = "Put after applying a filter",
			},
			{
				"=P",
				"<Plug>(YankyPutBeforeFilter)",
				desc = "Put before applying a filter",
			},
			{
				"<leader>p",
				function()
					Snacks.picker.yanky()
				end,
				mode = { "n", "x" },
				desc = "Open Yank History",
			},
		},
		opts = {
			picker = {
				ring = { storage = "sqlite" },
				-- telescope = {
				-- 	use_default_mappings = true,
				-- },
			},
		},
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
		"monaqa/dial.nvim",
		enabled = true,
		keys = {
			{
				"<C-a>",
				mode = { "n", "v" },
			},
			{
				"<C-x>",
				mode = { "n", "v" },
			},
			{
				"g<C-a>",
				mode = { "n", "v" },
			},
			{
				"g<C-x>",
				mode = { "n", "v" },
			},
		},
		config = function()
			vim.keymap.set("n", "<C-a>", function()
				require("dial.map").manipulate("increment", "normal")
			end)
			vim.keymap.set("n", "<C-x>", function()
				require("dial.map").manipulate("decrement", "normal")
			end)
			vim.keymap.set("n", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gnormal")
			end)
			vim.keymap.set("n", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gnormal")
			end)
			vim.keymap.set("v", "<C-a>", function()
				require("dial.map").manipulate("increment", "visual")
			end)
			vim.keymap.set("v", "<C-x>", function()
				require("dial.map").manipulate("decrement", "visual")
			end)
			vim.keymap.set("v", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gvisual")
			end)
			vim.keymap.set("v", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gvisual")
			end)

			local augend = require("dial.augend")

			local ordinal_numbers = augend.constant.new({
				elements = {
					"first",
					"second",
					"third",
					"fourth",
					"fifth",
					"sixth",
					"seventh",
					"eighth",
					"ninth",
					"tenth",
				},
				word = false,
				cyclic = true,
			})

			local weekdays = augend.constant.new({
				elements = {
					"Monday",
					"Tuesday",
					"Wednesday",
					"Thursday",
					"Friday",
					"Saturday",
					"Sunday",
				},
				word = true,
				cyclic = true,
			})

			local months = augend.constant.new({
				elements = {
					"January",
					"February",
					"March",
					"April",
					"May",
					"June",
					"July",
					"August",
					"September",
					"October",
					"November",
					"December",
				},
				word = true,
				cyclic = true,
			})

			local capitalized_boolean = augend.constant.new({
				elements = {
					"True",
					"False",
				},
				word = true,
				cyclic = true,
			})

			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					ordinal_numbers,

					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%d/%m/%Y"],
					augend.date.alias["%d/%m/%y"],
					augend.date.alias["%H:%M"],
					augend.date.alias["%H:%M:%S"],
					weekdays,
					months,

					augend.semver.alias.semver,

					augend.constant.alias.bool,
					capitalized_boolean,

					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})
		end,
	},
}
