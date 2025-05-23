return {
	"amitds1997/remote-nvim.nvim",
	enabled = false,
	version = "*",
	cmd = { "RemoteStart", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
	dependencies = {
		"nvim-lua/plenary.nvim", -- For standard functions
		"MunifTanjim/nui.nvim", -- To build the plugin UI
		"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
	},
	config = function()
		require("remote-nvim").setup({
			-- Source: https://github.com/amitds1997/remote-nvim.nvim/wiki/Configuration-recipes#launch-a-new-wezterm-tab-with-custom-title-when-launching-neovim-client
			client_callback = function(port, workspace_config)
				local cmd = ("wezterm cli set-tab-title --pane-id $(wezterm cli spawn nvim --server localhost:%s --remote-ui) %s"):format(
					port,
					("'Remote: %s'"):format(workspace_config.host)
				)
				vim.fn.jobstart(cmd, {
					detach = true,
					on_exit = function(job_id, exit_code, event_type)
						-- This function will be called when the job exits
						print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
					end,
				})
			end,
		})
	end,
}
