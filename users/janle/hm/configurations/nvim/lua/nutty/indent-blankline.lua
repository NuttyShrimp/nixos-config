vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("ibl").setup {
  indent = {
    tab_char = "⋅",
  }
}
