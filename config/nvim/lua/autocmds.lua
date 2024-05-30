vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        group = vim.api.nvim_create_augroup("clean_whitespace", { clear = true }),
        callback = function()
            print("Hello world")
            -- delete trailing whitespace
            vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])
            -- delete trailing empty lines
            vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])
        end,
    }
)
