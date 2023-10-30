require('lualine').setup({
  options = {
    theme = 'auto',
  },
  sections = {
    lualine_c = {
      { 'filename', file_status = true, path = 1 },
      -- 'lsp_progress'
    }
  }
})
