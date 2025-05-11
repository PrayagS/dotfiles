return {
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
			{ "nvim-mini/mini.icons", version = false },
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
						components = {
							label = {
								text = function(ctx)
									if ctx.item and ctx.item.label then
										return ctx.item.label
									end
									return ctx.label
								end,
							},
							label_description = {
								text = function(ctx)
									if ctx.item and ctx.item.detail then
										return ctx.item.detail
									end
									return ctx.label_description
								end,
							},
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
					border = "bold",
					-- Ref: https://main.cmp.saghen.dev/recipes#avoid-multi-line-completion-ghost-text
					direction_priority = function()
						local ctx = require("blink.cmp").get_context()
						local item = require("blink.cmp").get_selected_item()
						if ctx == nil or item == nil then
							return { "s", "n" }
						end

						local item_text = item.textEdit ~= nil and item.textEdit.newText
							or item.insertText
							or item.label
						local is_multi_line = item_text:find("\n") ~= nil

						-- after showing the menu upwards, we want to maintain that direction
						-- until we re-open the menu, so store the context id in a global variable
						if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
							vim.g.blink_cmp_upwards_ctx_id = ctx.id
							return { "n", "s" }
						end
						return { "s", "n" }
					end,
				},
				documentation = {
					auto_show = true,
					window = { border = "bold" },
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
				window = { border = "bold" },
			},
		},
	},
}
