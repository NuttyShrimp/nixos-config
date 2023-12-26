require('copilot').setup({
  panel = {
    auto_refresh = true,
  },
  filetypes = {},
  copilot_node_command = 'node', -- Node.js version must be > 18.x
})

require("copilot_cmp").setup()
