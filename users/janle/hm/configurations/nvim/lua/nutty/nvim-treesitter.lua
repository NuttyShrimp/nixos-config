require('nvim-treesitter.configs').setup({
  sync_install = true,
  auto_install = true,
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  parser_install_dir = "/home/janle/.local/share/nvim/tree-sitter/parsers"
})
