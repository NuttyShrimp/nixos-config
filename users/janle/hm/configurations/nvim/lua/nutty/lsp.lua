local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

local status, saga = pcall(require, "lspsaga")
if (not status) then return end

require("lspsaga").setup {
  server_filetype_map = {
    typescript = 'typescript'
  }
}
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'ga', '<Cmd>Lspsaga code_action<CR>', opts)


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local o_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}

-- Setup nvim-cmp.
local cmp = require 'cmp'
local lspkind = require("lspkind")

cmp.setup({
  performance = {
    debounce = 150,
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-j>'] = cmp.mapping.confirm({ select = true }),
  }),

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      vim_item.menu = menu

      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
        if icon then
          vim_item.kind = icon
          vim_item.kind_hl_group = hl_group
        end
      end
      return vim_item
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
    { name = "path" },
  }, {
    { name = "buffer", keyword_length = 3 },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    },
    {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
      { name = 'path' }
    },
    {
      { name = 'cmdline' }
    })
})

local lsp_servers = { "tsserver", "gopls", "html", "vimls", "jsonls", "eslint", "pyright", "volar", "cssls", "prismals",
  "clangd", "rust_analyzer", "svelte", "solargraph", "lua_ls", "golangci_lint_ls", "sqlls", "tailwindcss",
  "ansiblels" }
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers_to_skip = { lua_ls = true, eslint = true }
for _, lsp in ipairs(lsp_servers) do
  if servers_to_skip[lsp] then goto continue end
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  ::continue::
end

require('lspconfig').lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  Lua = {
    diagnostics = {
      enable = true,
      disable = { "lowercase-global", "undefined-field", "undefined-global" },
      globals = { 'source' }
    },
    runtime = {
      nonstandardSymbol = {
        "/**/", "`", "+=", "-=", "*=", "/=",
      },
      plugin = "/home/janle/project/git/dotfiles/data/cfxlua-vscode/plugin.lua",
      version = "Lua 5.4"
    },
    completion = {
      autoRequire = false,
    },
    IntelliSense = {
      traceBeSetted = true,
      traceLocalSet = true,
      traceFieldInject = true,
      traceReturn = true,
    },
    workspace = {
      preloadFileSize = 2000,
      ignoreDir = { ".vscode", ".github", ".git", "**/node_modules" },
      library = "/home/janle/project/git/dotfiles/data/cfxlua-vscode/library",
      useGitIgnore = true,
      checkThirdParty = false
    },
    telemetry = {
      enable = true
    }
  }
}

require('lspconfig').eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
  }
}

require "fidget".setup {}
