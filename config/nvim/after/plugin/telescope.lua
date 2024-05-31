local lga_actions = require("telescope-live-grep-args.actions")

require("telescope").setup({
    defaults = {
        path_display = {
            "smart",
        },
        dynamic_preview_title = true,
    },
    pickers = {
        grep_string = {
            use_regex = true,
        },
        find_files = {
            follow = true,
            hidden = true,
        }
    },
    extensions = {
        live_grep_args = {
            auto_quoting = false, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        },
    },
})
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("frecency")

local builtin = require('telescope.builtin')
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>p", builtin.find_files, {})
vim.keymap.set("n", "<leader>g", builtin.current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>gw", live_grep_args_shortcuts.grep_word_under_cursor, {})
vim.keymap.set("n", "<leader>G", builtin.live_grep, {})
vim.keymap.set("v", "<leader>gv", live_grep_args_shortcuts.grep_visual_selection, {})

-- https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

vim.keymap.set("v", "<leader>g", function()
	local text = vim.getVisualSelection()
	builtin.current_buffer_fuzzy_find({ default_text = text })
end, {})

-- vim.keymap.set("v", "<leader>G", function()
-- 	local text = vim.getVisualSelection()
-- 	builtin.live_grep({ default_text = text })
-- end, {})

vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
