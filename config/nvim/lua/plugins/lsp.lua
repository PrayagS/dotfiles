-- TODO: https://gpanders.com/blog/whats-new-in-neovim-0-11/#simpler-lsp-setup-and-configuration
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "BufWritePre" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"kosayoda/nvim-lightbulb",
				opts = {
					autocmd = { enabled = true },
					number = { enabled = true },
				},
			},
			{
				"chrisgrieser/nvim-lsp-endhints",
				enabled = false,
				opts = {},
			},
			{
				"Zeioth/garbage-day.nvim",
				opts = {
					grace_period = 30 * 60,
					notifications = true,
				},
			},
		},
		config = function()
			-- configure lsp keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")

					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
						and vim.lsp.inlay_hint
					then
						-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end

					if client and client:supports_method("textDocument/foldingRange") then
						local win = vim.api.nvim_get_current_win()
						vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
					end

					if client and client.name == "ruff" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end

					if client and client.name == "yamlls" then
						client.server_capabilities.documentFormattingProvider = true
					end
				end,
			})

			-- configure diagnostics
			vim.diagnostic.config({
				virtual_text = {
					severity = {
						max = vim.diagnostic.severity.WARN,
					},
				},
				virtual_lines = {
					severity = {
						min = vim.diagnostic.severity.ERROR,
					},
				},
				-- update_in_insert = true,
				severity_sort = true,
				float = {
					source = "if_many",
					border = "rounded",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						completion = {
							displayContext = 5,
						},
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
						hint = {
							enable = true,
							setType = true,
						},
						codeLens = { enable = true },
					},
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						staticcheck = true,
						gofumpt = true,
						codelenses = {
							gc_details = true,
							generate = true,
							regenerate_cgo = true,
							test = true,
							run_govulncheck = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						usePlaceholders = true,
						analyses = {
							shadow = true,
							unusedvariable = true,
							useany = true,
						},
						vulncheck = "Imports",
					},
				},
			})

			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						lineLength = 80,
					},
				},
			})

			vim.lsp.config("tinymist", {
				settings = {
					exportPdf = "onSave",
					formatterMode = "typstyle",
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						format = {
							enable = true,
							singleQuote = true,
							bracketSpacing = true,
						},
						validate = true,
						hover = true,
						completion = true,
					},
				},
			})

			vim.lsp.config("helm_ls", {
				settings = {
					["helm-ls"] = {
						yamlls = {
							enabled = false,
						},
					},
				},
			})

			vim.lsp.enable("rust_analyzer")

			require("mason").setup()

			local ensure_installed = {}
			vim.list_extend(ensure_installed, {
				"golangci-lint",
				"yamllint",
			})
			vim.list_extend(ensure_installed, {
				"stylua",
				"goimports",
				"golines",
				"shfmt",
			})
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				run_on_start = true,
				-- debounce_hours = 24,
				integrations = {
					["mason-lspconfig"] = true,
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				automatic_enable = {
					"lua_ls",
					"gopls",
					"ruff",
					"ty",
					"tinymist",
					"yamlls",
					"helm_ls",
					"rust_analyzer",
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
			modes = {
				symbols = {
					focus = true,
					win = {
						type = "split",
						relative = "editor",
						size = 0.25,
						position = "left",
					},
				},
			},
		},
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = function()
			require("symbol-usage").setup({
				references = { enabled = true, include_declaration = true },
				definition = { enabled = true },
				implementation = { enabled = true },
			})
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		enabled = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		opts = {
			bar = {
				sources = function(buf, _)
					local sources = require("dropbar.sources")
					local utils = require("dropbar.utils")
					if vim.bo[buf].ft == "markdown" then
						return { sources.markdown }
					end
					if vim.bo[buf].buftype == "terminal" then
						return { sources.terminal }
					end
					return { utils.source.fallback({ sources.lsp, sources.treesitter }) }
				end,
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		enabled = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
				default_direction = "prefer_left",
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle left<CR>")
			vim.keymap.set("n", "<leader>af", "<cmd>Telescope aerial<CR>")
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		keys = {
			{
				"<leader>ca",
				function()
					require("actions-preview").code_actions()
				end,
				desc = "preview code actions",
			},
		},
		config = function()
			require("actions-preview").setup({
				diff = {
					algorithm = "patience",
					ctxlen = 5,
				},
				highlight_command = {
					require("actions-preview.highlight").delta("delta --features=gruvbox-dark-code-actions-preview"),
				},
				backend = { "snacks", "telescope", "nui" },
				snacks = {
					layout = { preset = "dropdown" },
				},
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.8,
						height = 0.9,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = function(_, _, max_lines)
							return max_lines - 15
						end,
					},
				},
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		keys = {
			{
				"gpd",
				function()
					require("goto-preview").goto_preview_definition()
				end,
				desc = "",
			},
			{
				"gpt",
				function()
					require("goto-preview").goto_preview_type_definition()
				end,
				desc = "",
			},
			{
				"gpi",
				function()
					require("goto-preview").goto_preview_implementation()
				end,
				desc = "",
			},
			{
				"gpD",
				function()
					require("goto-preview").goto_preview_declaration()
				end,
				desc = "",
			},
			{
				"gP",
				function()
					require("goto-preview").close_all_win()
				end,
				desc = "",
			},
			{
				"gpr",
				function()
					require("goto-preview").goto_preview_references()
				end,
				desc = "",
			},
		},
		config = true,
	},
}
