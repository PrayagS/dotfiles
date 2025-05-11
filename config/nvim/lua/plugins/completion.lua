return {
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"hrsh7th/cmp-nvim-lua",
	-- 		"onsails/lspkind.nvim",
	-- 		"chrisgrieser/cmp_yanky",
	-- 		"ray-x/cmp-treesitter",
	-- 		"petertriho/cmp-git",
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		local lspkind = require("lspkind")
	--
	-- 		cmp.setup({
	-- 			window = {
	-- 				completion = {
	-- 					border = {
	-- 						{ "󱐋", "WarningMsg" },
	-- 						{ "─", "Comment" },
	-- 						{ "╮", "Comment" },
	-- 						{ "│", "Comment" },
	-- 						{ "╯", "Comment" },
	-- 						{ "─", "Comment" },
	-- 						{ "╰", "Comment" },
	-- 						{ "│", "Comment" },
	-- 					},
	-- 					scrollbar = false,
	-- 				},
	-- 				documentation = {
	-- 					border = {
	-- 						{ "", "DiagnosticHint" },
	-- 						{ "─", "Comment" },
	-- 						{ "╮", "Comment" },
	-- 						{ "│", "Comment" },
	-- 						{ "╯", "Comment" },
	-- 						{ "─", "Comment" },
	-- 						{ "╰", "Comment" },
	-- 						{ "│", "Comment" },
	-- 					},
	-- 					scrollbar = false,
	-- 				},
	-- 			},
	-- 			completion = {
	-- 				completeopt = "menu,menuone,noinsert",
	-- 			},
	-- 			mapping = {
	-- 				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<C-y>"] = cmp.mapping.confirm({
	-- 					behavior = cmp.ConfirmBehavior.Replace,
	-- 					select = true,
	-- 				}),
	-- 			},
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "treesitter" },
	-- 				{ name = "nvim_lua" },
	-- 				{ name = "git" },
	-- 				{ name = "path" },
	-- 				{ name = "cmp_yanky" },
	-- 				{
	-- 					name = "buffer",
	-- 					option = {
	-- 						get_bufnrs = function()
	-- 							local bufs = {}
	-- 							for _, win in ipairs(vim.api.nvim_list_wins()) do
	-- 								bufs[vim.api.nvim_win_get_buf(win)] = true
	-- 							end
	-- 							return vim.tbl_keys(bufs)
	-- 						end,
	-- 					},
	-- 				},
	-- 			}),
	-- 			formatting = {
	-- 				format = lspkind.cmp_format({
	-- 					mode = "symbol_text",
	-- 				}),
	-- 			},
	-- 		})
	--
	-- 		require("cmp_git").setup()
	--
	-- 		cmp.setup.cmdline({ "/", "?" }, {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "buffer" },
	-- 			},
	-- 		})
	--
	-- 		cmp.setup.cmdline({ ":" }, {
	-- 			mapping = cmp.mapping.preset.cmdline(),
	-- 			sources = {
	-- 				{ name = "cmdline" },
	-- 				{ name = "path" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		build = "cargo build --release",
		dependencies = {
			{ "mikavilpas/blink-ripgrep.nvim", version = "*" },
			"Kaiser-Yang/blink-cmp-git",
			"ribru17/blink-cmp-spell",
			"disrupted/blink-cmp-conventional-commits",
			"junkblocker/blink-cmp-wezterm",
		},
		-- version = "*",
		opts = {
			completion = {
				keyword = {
					range = "full",
				},
				menu = {
					draw = {
						treesitter = { "lsp" },
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
					},
				},
				documentation = {
					auto_show = true,
				},
				ghost_text = { enabled = true },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = {
					"lsp",
					"minuet",
					"path",
					"buffer",
					"omni",
					"spell",
					"ripgrep",
				},
				per_filetype = {
					gitcommit = { "conventional_commits", "git", "buffer", "path" },
					jjdescription = { "conventional_commits", "git", "buffer", "path" },
				},
				providers = {
					minuet = {
						name = "minuet",
						module = "minuet.blink",
						async = true,
						-- Should match minuet.config.request_timeout * 1000,
						-- since minuet.config.request_timeout is in seconds
						timeout_ms = 3000,
						-- score_offset = 50, -- Gives minuet higher priority among suggestions
					},
					cmdline = {
						min_keyword_length = function(ctx)
							-- only applies when typing a command, doesn't apply to arguments
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
					buffer = {
						opts = { get_bufnrs = vim.api.nvim_list_bufs },
					},
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						score_offset = 1, -- boost lsp completions
						fallbacks = {},
					},
					path = {
						opts = { show_hidden_files_by_default = true },
					},
					spell = {
						name = "Spell",
						module = "blink-cmp-spell",
						opts = {
							max_entries = 10,
						},
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {
							prefix_min_len = 5,
							backend = {
								use = "ripgrep",
								ripgrep = {
									search_casing = "--smart-case",
									additional_rg_options = {
										"--follow --hidden --nno-binary,",
									},
								},
							},
						},
					},
					git = {
						module = "blink-cmp-git",
						name = "Git",
						opts = {
							kind_icons = {
								Commit = "",
								Mention = "",
								PR = "",
								Issue = "",
							},
						},
					},
					conventional_commits = {
						name = "Conventional Commits",
						module = "blink-cmp-conventional-commits",
					},
					wezterm = {
						module = "blink-cmp-wezterm",
						name = "wezterm",
						opts = {
							all_panes = true,
							capture_history = false,
							-- triggered_only = false,
							-- trigger_chars = { "." },
						},
					},
				},
			},
			cmdline = {
				enabled = true,
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},
			signature = {
				enabled = true,
			},
		},
	},
}
