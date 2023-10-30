require 'nvim-tree'.setup {
  renderer = {
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      }
    },
  },
  filters = {
    dotfiles = true,
  },
  git = {
    ignore = false
  }
}
