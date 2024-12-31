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
				blank = nil,
			},
			notifier = {
				enabled = true,
				style = "compact",
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
