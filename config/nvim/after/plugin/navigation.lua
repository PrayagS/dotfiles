-- require("leap").create_default_mappings()
vim.keymap.set("n",        "s", "<Plug>(leap)")
vim.keymap.set("n",        "S", "<Plug>(leap-from-window)")
vim.keymap.set({"x", "o"}, "s", "<Plug>(leap-forward)")
vim.keymap.set({"x", "o"}, "S", "<Plug>(leap-backward)")

require("mini.bracketed").setup({
    yank = { suffix = '', options = {} },
})

require('flit').setup {
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "v",
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {}
}
