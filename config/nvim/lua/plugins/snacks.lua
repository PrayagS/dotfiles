return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>q",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers({
						layout = {
							preset = "vscode",
							layout = {
								row = 3,
								border = "rounded",
							},
						},
					})
				end,
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history({
						layout = {
							preset = "vscode",
							layout = {
								row = 3,
								border = "rounded",
							},
						},
					})
				end,
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.commands({
						layout = {
							preset = "vscode",
							layout = {
								row = 3,
								border = "rounded",
							},
						},
					})
				end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics({
						layout = { preset = "ivy" },
					})
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer({
						layout = { preset = "ivy_split" },
					})
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files({
						hidden = true,
						follow = true,
						live = true,
					})
				end,
				desc = "Find Files",
			},
			{
				"<C-p>",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word({ live = true })
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_word({ buffers = true, live = true })
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{
				"<leader>hh",
				function()
					Snacks.picker.help({
						layout = { preset = "ivy" },
					})
				end,
				desc = "Help Pages",
			},
			{
				"<leader>kk",
				function()
					Snacks.picker.keymaps({
						layout = { preset = "ivy" },
					})
				end,
				desc = "Keymaps",
			},
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history({
						layout = {
							preset = "vscode",
							layout = {
								row = 3,
								border = "rounded",
							},
						},
					})
				end,
				desc = "Search History",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
		},
		opts = {
			animate = {
				fps = "120",
			},
			scroll = {
				enabled = true,
				animate = {
					duration = { step = 15, total = 250 },
					fps = "120",
					-- List of easing functions: https://github.com/kikito/tween.lua#easing-functions
					-- Demo: https://easings.net/
					-- To mess with someone, set this to `inOutBounce` or `inOutElastic` ;)
					easing = "inOutExpo",
				},
			},
			indent = {
				indent = {
					char = "⎥",
					blank = nil,
				},
				animate = {
					style = "up_down",
					duration = {
						step = 10,
						total = 250,
					},
					easing = "outExpo",
				},
				chunk = {
					enabled = true,
					char = {
						corner_top = "┏",
						corner_bottom = "┗",
						horizontal = "╍",
						vertical = "╏",
						arrow = ">",
					},
				},
				blank = nil,
			},
			notifier = {
				enabled = true,
				style = "compact",
			},
			picker = {
				matcher = {
					cwd_bonus = true,
					frecency = true,
				},
				ui_select = true,
			},
		},
		init = function()
			-- LSP progress
			---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
			local progress = vim.defaulttable()
			vim.api.nvim_create_autocmd("LspProgress", {
				---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
					if not client or type(value) ~= "table" then
						return
					end
					local p = progress[client.id]

					for i = 1, #p + 1 do
						if i == #p + 1 or p[i].token == ev.data.params.token then
							p[i] = {
								token = ev.data.params.token,
								msg = ("[%3d%%] %s%s"):format(
									value.kind == "end" and 100 or value.percentage or 100,
									value.title or "",
									value.message and (" **%s**"):format(value.message) or ""
								),
								done = value.kind == "end",
							}
							break
						end
					end

					local msg = {} ---@type string[]
					progress[client.id] = vim.tbl_filter(function(v)
						return table.insert(msg, v.msg) or not v.done
					end, p)

					local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					vim.notify(table.concat(msg, "\n"), "info", {
						id = "lsp_progress",
						title = client.name,
						opts = function(notif)
							notif.icon = #progress[client.id] == 0 and " "
								or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
						end,
					})
				end,
			})
		end,
	},
}
