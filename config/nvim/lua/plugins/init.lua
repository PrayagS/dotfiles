return {
	-- The state of session management plugins,
	-- -> rmagutti/auto-session:
	-- - Auto save and restore
	-- - Git branching support
	-- - Only creates a session when nvim is opened as is
	-- - Supports hooks
	-- - Telescope support
	-- - Most no. of stars out of all the plugins listed here
	--
	-- -> olimorris/persisted.nvim:
	-- - Auto save and restore
	-- - Git branching support
	-- - Only creates a session when nvim is opened as is
	-- - Supports hooks
	-- - Telescope support
	--
	-- -> stevearc/resession.nvim
	-- - Everything is configured manually -> auto save/restore, git branching
	-- support, hooks, telescope support, etc.
	-- - The pro is that it has a convenient API to persist data from other
	-- plugins since it doesn't use :mksession.
	--
	-- -> jedrzejboczar/possession.nvim:
	-- - Only autosaves if you're already in a session
	-- - Creates a session even when nvim is opened for a specific file
	-- - Supports hooks
	-- - Telescope support
	-- - Git branching support has to be configured manually.
	-- - Isn't restricted by :mksession, can persist data from other plugins
	--
	-- -> Shatur/neovim-session-manager:
	-- - Auto save and restore
	-- - Creates a session even when nvim is opened for a specific file
	-- - Git branching support has to be configured manually.
	-- - Telescope support
	-- - Supports hooks
	--
	-- TODO: Configure switching sessions smoothly when changing branches from
	-- inside nvim.
	-- Issue with lazy: https://github.com/rmagatti/auto-session/issues/223
	{
		-- "rmagatti/auto-session",
		"cameronr/auto-session",
		branch = "restore-error-handler",
		opts = {
			auto_save_enabled = true,
			auto_restore_enabled = true,
			auto_session_use_git_branch = true,
			suppressed_dirs = {
				"~/",
			},
			session_lens = {
				load_on_setup = false,
			},
			-- log_level = "debug",
		},
	},
	-- {
	-- 	"olimorris/persisted.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("persisted").setup({
	-- 			use_git_branch = true,
	-- 			autoload = true,
	-- 			on_autoload_no_session = function()
	-- 				return
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
