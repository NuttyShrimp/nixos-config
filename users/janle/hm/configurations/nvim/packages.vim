call plug#begin()

Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'onsails/lspkind.nvim'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Language plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'maxmellon/vim-jsx-pretty'

" Lines for indentation
Plug 'lukas-reineke/indent-blankline.nvim'

" Icons for some plugins
Plug 'kyazdani42/nvim-web-devicons'

" Telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'folke/trouble.nvim'

" Lualine
Plug 'nvim-lualine/lualine.nvim'
" Plug 'arkav/lualine-lsp-progress'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

" File tree
Plug 'kyazdani42/nvim-tree.lua', { 'commit':  '8b8d457' }

" editorconfig
Plug 'editorconfig/editorconfig-vim'

Plug 'wakatime/vim-wakatime'

Plug 'ghifarit53/tokyonight-vim'

Plug 'jiangmiao/auto-pairs'

Plug 'folke/todo-comments.nvim'

" Toggle comments
Plug 'tpope/vim-commentary'

" git blame
Plug 'lewis6991/gitsigns.nvim'

" tmux resurrect
Plug 'tpope/vim-obsession'

" Rust tools
Plug 'simrat39/rust-tools.nvim'

call plug#end()
