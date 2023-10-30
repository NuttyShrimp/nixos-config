-- line enable relative number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- enable mouse
vim.opt.mouse = "a"

vim.g.mapleader = " "

-- Store an undo buffer in a file in nvims default folder ($XDG_DATA_HOME/nvim/undo)
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.scrolloff = 999

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.showmatch = true

vim.opt.termguicolors = true

-- Indentation
-- length of an actual \t character:
vim.opt.tabstop = 2
-- length to use when editing text (eg. TAB and BS keys)
-- (0 for ‘tabstop’, -1 for ‘shiftwidth’):
vim.opt.softtabstop = 0
-- length to use when shifting text (eg. <<, >> and == commands)
-- (0 for ‘tabstop’):
vim.opt.shiftwidth = 0
-- round indentation to multiples of 'shiftwidth' when shifting text
-- (so that it behaves like Ctrl-D / Ctrl-T):
vim.opt.shiftround = true
-- if set, only insert spaces; otherwise insert \t and complete with spaces:
vim.opt.expandtab = true

-- try to be smart (increase the indenting level after ‘{’,
-- decrease it after ‘}’, and so on):
vim.opt.smartindent = true

vim.cmd.syntax(true)

vim.cmd.filetype({ "plugin", "indent", "on" })

-- Ignore various cache/vendor folders
vim.opt.wildignore:append({
  "*/node_modules/*",
  "*/dist/*",
  "*/__pycache__/*",
  "*/venv/*",
  "*/target/*",
  "*/.git/*",
})
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
require("lazy").setup("plugins")

require("nutty")

vim.g.go_gopls_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
