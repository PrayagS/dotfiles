return {
	-- TODO: nvim-treesitter/nvim-treesitter-textobjects
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
		},
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cue",
				"dockerfile",
				"git_config",
				"gitcommit",
				"go",
				"gomod",
				"gotmpl",
				"json",
				"jsonnet",
				"lua",
				"markdown",
				"promql",
				"python",
				"rust",
				"terraform",
				"yaml",
				"vimdoc",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
			refactor = {
				highlight_definitions = { enable = true },
				-- highlight_current_scope = { enable = true },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		opts = {},
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = { "<space>m", "<space>j", "<space>s" },
		opts = {},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
	},
}
