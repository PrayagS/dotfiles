return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters.jsonnet_lint = {
			cmd = "jsonnet-lint",
			stdin = true,
			args = { "-" },
			stream = "stdout",
			ignore_exitcode = true,
			parser = require("lint.parser").from_errorformat("%f:%l:%c-%k %m"),
		}

		local gitlint = lint.linters.gitlint
		gitlint.args = {
			"--contrib",
			"contrib-title-conventional-commits,contrib-body-requires-signed-off-by",
			"--staged",
			"--msg-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}

		lint.linters_by_ft = {
			jsonnet = { "jsonnet_lint" },
			-- go = { "golangcilint" },
			yaml = { "yamllint" },
			gitcommit = { "gitlint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
