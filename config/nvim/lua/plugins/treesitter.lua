return {
	-- TODO: nvim-treesitter/nvim-treesitter-textobjects
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ensure_installed = {
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
				"just",
				"lua",
				"markdown",
				"promql",
				"python",
				"rust",
				"terraform",
				"typst",
				"yaml",
				"vimdoc",
			}

			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = ensure_installed,
				callback = function()
					vim.treesitter.start()
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		-- enabled = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		opts = {
			multiwindow = true,
		},
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = { "<space>m", "<space>j", "<space>s" },
		opts = {},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		cmd = "Refactoring",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
	},
}
