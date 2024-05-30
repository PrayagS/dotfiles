require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
})

require('gitlinker').setup()
vim.keymap.set(
  {"n", 'v'},
  "<leader>gL",
  function()
    require("gitlinker").link({ action = require("gitlinker.actions").system })
  end,
  { silent = true, noremap = true, desc = "GitLink!" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>gB",
  function()
    require("gitlinker").link({
      router_type = "blame",
      action = require("gitlinker.actions").system,
    })
  end,
  { silent = true, noremap = true, desc = "GitLink! blame" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>gD",
  function()
    require("gitlinker").link({
      router_type = "default_branch",
      action = require("gitlinker.actions").system,
    })
  end,
  { silent = true, noremap = true, desc = "GitLink! default_branch" }
)
vim.keymap.set(
  {"n", 'v'},
  "<leader>gC",
  function()
    require("gitlinker").link({
      router_type = "current_branch",
      action = require("gitlinker.actions").system,
    })
  end,
  { silent = true, noremap = true, desc = "GitLink! current_branch" }
)

require("diffview").setup()
