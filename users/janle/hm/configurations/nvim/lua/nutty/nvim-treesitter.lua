local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"

vim.opt.runtimepath:append(parser_install_dir)

require('nvim-treesitter.configs').setup({
  sync_install = true,
  auto_install = true,
  highlight = { enable = true, disable = { "rust" } },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  parser_install_dir = parser_install_dir
})
