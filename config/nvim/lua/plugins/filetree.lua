return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
        require("nvim-tree").setup({
            hijack_cursor = true,
            update_focused_file = {
                enable = true,
            },
            view = {
                centralize_selection = true,
            },
            renderer = {
                add_trailing = true,
                group_empty = true,
                indent_markers = {
                    enable = true,
                },
            },
            diagnostics = {
                enable = true,
            },
            tab = {
                sync = {
                    open = true,
                },
            },
        })

        -- vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        vim.keymap.set(
            "n",
            "<leader>f",
            function()
                -- Source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#smart-nvim-tree-toggling
                local nvimTree=require("nvim-tree.api")
                local currentBuf = vim.api.nvim_get_current_buf()
                local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
                if currentBufFt == "NvimTree" then
                    nvimTree.tree.toggle()
                else
                    nvimTree.tree.focus()
                end
            end,
            { noremap = true, silent = true }
        )

        vim.keymap.set(
            "n",
            "<leader>pd",
            function()
                -- Source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#find-and-focus-directory-with-telescope
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                local function open_nvim_tree(prompt_bufnr, _)
                    actions.select_default:replace(function()
                    local api = require("nvim-tree.api")

                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    api.tree.open()
                    api.tree.find_file(selection.cwd .. "/" .. selection.value)
                    end)
                    return true
                end

                require("telescope.builtin").find_files({
                    find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
                    attach_mappings = open_nvim_tree,
                })
            end,
            { noremap = true, silent = true }
        )
    end,
}