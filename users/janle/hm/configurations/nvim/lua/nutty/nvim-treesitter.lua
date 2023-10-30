require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'css',
    'html',
    'javascript',
    'typescript',
    'go',
    'tsx',
    'vim',
    'lua',
    'vue',
    'json',
    'yaml'
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true }
})
