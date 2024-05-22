require("vim-config")
require("nix-config")
-- vim.cmd("runtime packages.vim")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  dev = {
    path = "~/.local/share/nvim/nix",
    fallback = false,
  }
  -- config = {
  --   performance = {
  --     reset_packpath = false
  --   }
  -- }
})

require("nutty")
