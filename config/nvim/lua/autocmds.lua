vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("clean_whitespace", { clear = true }),
	callback = function()
		-- delete trailing whitespace
		-- vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])
		MiniTrailspace.trim()
		-- delete trailing empty lined
		MiniTrailspace.trim_last_lines()
		-- vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	group = vim.api.nvim_create_augroup("remap_enter_to_default_in_cmdline_window", { clear = true }),
	pattern = "*",
	callback = function()
		vim.keymap.set("n", "<CR>", "<CR>", {
			buffer = true,
		})
	end,
})

vim.api.nvim_create_autocmd({ "CmdLineEnter" }, {
	group = vim.api.nvim_create_augroup("emulate_arrow_keys_in_search", { clear = true }),
	pattern = "*",
	callback = function()
		vim.keymap.set("c", "<C-j>", "<Down>", {
			buffer = true,
		})
		vim.keymap.set("c", "<C-k>", "<Up>", {
			buffer = true,
		})
	end,
})
