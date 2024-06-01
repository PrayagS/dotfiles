vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("clean_whitespace", { clear = true }),
	callback = function()
		-- save current cursor location
		local cursor_position_before_save = vim.api.nvim_win_get_cursor(0)
		local line, column = cursor_position_before_save[1], cursor_position_before_save[2]

		-- delete trailing whitespace
		vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])
		-- delete trailing empty lined
		vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])

		-- restore cursor position
		if line > vim.fn.line("$") then
			line = vim.fn.line("$")
		end
		vim.api.nvim_win_set_cursor(0, { line, column })
	end,
})
