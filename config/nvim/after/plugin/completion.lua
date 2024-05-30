local cmp = require("cmp")
local defaults = require("cmp.config.default")()
local lspkind = require("lspkind")

cmp.setup({
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = 'nvim_lua' },
        { name = "cmp_yanky" },
    }),
    sorting = defaults.sorting,
    formatting = {
        format = lspkind.cmp_format {
            mode = "symbol_text",
        },
    },

})

cmp.setup.cmdline({"/", "?"}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline({":"}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
    },
})
