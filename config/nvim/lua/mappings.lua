local set = vim.keymap.set

-- Set space as leader key
vim.g.mapleader = " "

-- "Best keybindings ever". Source: ThePrimeagen
-- Move lines in visual mode
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace the word present at cursor
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Append next line to current one
set("n", "J", "mzJ`z")

-- Keep cursor at the middle when scrolling buffers
-- set("n", "<C-d>", "<C-d>zz")
-- set("n", "<C-u>", "<C-u>zz")

-- Keep cursor at the middle when searching
-- set("n", "n", "nzzzv")
-- set("n", "N", "Nzzzv")

-- Copy whole line
set("n", "Y", "y$")

-- Delete/Replace but don't overwrite the register with the deleted/replaced text
-- set("x", "<leader>p", [["_dP]])
set({ "n", "v" }, "d", [["_d]])
set({ "n", "v" }, "c", [["_c]])
set({ "n", "v" }, "x", [["_x]])
-- keymaps for cut since delete doesn't behave like cut given the above keymaps
set({ "n", "v" }, "m", "d", { noremap = true })
set({ "n", "v" }, "M", "D", { noremap = true })

-- Copy to the plus register
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

-- Keep cursor at the middle when browsing lists
-- set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Q toggles mode to ex mode
set("n", "Q", "<nop>")

-- better up/down
-- set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to windows using the <ctrl> hjkl keys
set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
set("n", "<C-S-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
set("n", "<C-S-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
set("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Add undo break-points
set("i", ",", ",<c-g>u")
set("i", ".", ".<c-g>u")
set("i", ";", ";<c-g>u")

-- save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")
