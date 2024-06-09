return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lua",
		"onsails/lspkind.nvim",
		"chrisgrieser/cmp_yanky",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			window = {
				completion = {
					border = {
						{ "󱐋", "WarningMsg" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
					scrollbar = false,
				},
				documentation = {
					border = {
						{ "", "DiagnosticHint" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
					scrollbar = false,
				},
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "cmp_yanky" },
				{
					name = "buffer",
					option = {
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
				}),
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline({ ":" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "cmdline" },
				{ name = "path" },
			},
		})
	end,
}
