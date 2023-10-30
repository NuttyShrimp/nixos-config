vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>")
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
