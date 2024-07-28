return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {
					progress = {
						display = {
							done_ttl = 30,
						},
					},
					notification = {
						window = {
							x_padding = 2,
							y_padding = 1,
							border = "single",
						},
					},
				},
			},
			{ "smjonas/inc-rename.nvim", opts = { input_buffer_type = "dressing" } },
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			{ "luckasRanarison/clear-action.nvim", opts = {} },
			{
				"aznhe21/actions-preview.nvim",
				config = function()
					require("actions-preview").setup({
						diff = {
							algorithm = "patience",
							ctxlen = 5,
						},
						highlight_command = {
							require("actions-preview.highlight").delta(
								"delta --features=gruvbox-dark-code-actions-preview"
							),
						},
						telescope = {
							sorting_strategy = "ascending",
							layout_strategy = "center",
							layout_config = {
								width = 0.4,
								height = 0.4,
								prompt_position = "bottom",
							},
						},
					})

					vim.keymap.set({ "n", "v" }, "<leader>ca", require("actions-preview").code_actions)
				end,
			},
			{
				"chrisgrieser/nvim-lsp-endhints",
				enabled = false,
				opts = {},
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
					-- Jump to the definition of the word under your cursor.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					-- Jump to the implementation of the word under your cursor.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					-- Jump to the type of the word under your cursor.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					-- Fuzzy find all the symbols in your current document.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					-- Fuzzy find all the symbols in your current workspace.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					-- Rename the variable under your cursor.
					-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>rn", ":IncRename ", "[R]e[n]ame")
					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					-- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					-- Opens a popup that displays documentation about the word under your cursor
					map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
					-- WARN: This is not Goto Definition, this is Goto Declaration.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
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

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			local servers = {
				lua_ls = {},
				gopls = {},
				jsonnet_ls = {},
				yamlls = {},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"golangci-lint",
				"yamllint",
			})
			vim.list_extend(ensure_installed, {
				"stylua",
				"goimports",
				"golines",
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
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						if server_name == "lua_ls" then
							server.settings = {
								Lua = {
									completion = {
										displayContext = 5,
									},
									diagnostics = {
										globals = { "vim" },
									},
									hint = {
										enable = true,
										setType = true,
									},
								},
							}
						end
						if server_name == "gopls" then
							server.settings = {
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
							}
						end
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- configure diagnostics
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
				-- update_in_insert = true,
				severity_sort = true,
				float = {
					source = "always",
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
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
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
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
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
		"rmagatti/goto-preview",
		event = "VeryLazy",
		config = true,
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
		config = true,
	},
	{
		"stevearc/aerial.nvim",
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
}
