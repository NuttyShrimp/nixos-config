return {
  {
    -- Optional
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim'
  },
  {
    'neovim/nvim-lspconfig'
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    'nvim-tree/nvim-web-devicons'
  },
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons'      -- optional
    }
  },
  {
    'hrsh7th/nvim-cmp'
  },
  {
    'hrsh7th/cmp-cmdline',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'hrsh7th/cmp-nvim-lua',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'hrsh7th/cmp-path',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'hrsh7th/cmp-buffer',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    'onsails/lspkind.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp'
    }
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    'saadparwaiz1/cmp_luasnip'
  },
  {
    'fatih/vim-go'
  },
  {
    'maxmellon/vim-jsx-pretty'
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  {
    'nvim-lua/plenary.nvim'
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-lualine/lualine.nvim",
  },
  {
    'j-hui/fidget.nvim',
    dependencies = { 'nvim-lualine/lualine.nvim' },
    branch = "legacy"
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    'editorconfig/editorconfig-vim'
  },
  { 'wakatime/vim-wakatime' },
  {
    'ghifarit53/tokyonight-vim',
    lazy = false,
    priority = 1000,
  },
  {
    'jiangmiao/auto-pairs'
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'tpope/vim-commentary'
  },
  {
    'lewis6991/gitsigns.nvim'
  },
  {
    'tpope/vim-obsession'
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = { 'hrsh7th/nvim-cmp' }
  }
}
