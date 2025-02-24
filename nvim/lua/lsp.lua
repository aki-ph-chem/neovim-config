-- LSP config
local home_dir = vim.env.HOME
-- depend on Python
vim.env.PATH = home_dir .. '/neovim-config/.venv/bin:' .. vim.env.PATH
-- depend on Node.js
vim.env.PATH = home_dir .. '/neovim-config/node_modules/.bin:' .. vim.env.PATH

-- lsp for log
local use_lsp_log_debug = false
if use_lsp_log_debug then
  vim.lsp.set_log_level('debug')
end
--- jump to definition by 'gd'
vim.keymap.set('n', 'gd', '<cmd>:lua vim.lsp.buf.definition()<CR>')

local navic = require('nvim-navic')
navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
  lsp = {
    auto_attach = true,
  },
  highlight = true,
  depth_limit = 9,
}
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

local read_lsp_config = function(path_to_config, config)
  local ok, project_config = pcall(dofile, path_to_config)
  if ok then
    config = project_config
  end

  return config
end

-- LSP for each programing language
-- python
local pyright_config = {
  settings = {
    python = {
      pythonPath = './.venv/bin/python',
    },
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
}

-- cpp
local clangd_config = {
  cmd = {
    'clangd',
    '--log=verbose',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--suggest-missing-includes',
    '--cross-file-rename',
  },
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
}

-- Rust
local rust_analyzer_config = {
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },

  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
}

-- Go
local gols_config = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- pyright
require('lspconfig').pyright.setup(pyright_config)

-- clangd
clangd_config = read_lsp_config(vim.fn.getcwd() .. '/clangd_config.lua', clangd_config)
require('lspconfig').clangd.setup(clangd_config)

-- CMake
require('lspconfig').cmake.setup({})

-- for rustfmt
vim.g.rustfmt_autosave = 1
-- rust-analyzer
rust_analyzer_config = read_lsp_config(vim.fn.getcwd() .. '/rust_analyzer_config.lua', rust_analyzer_config)
require('lspconfig').rust_analyzer.setup(rust_analyzer_config)

-- go lang
require('lspconfig').gopls.setup(gols_config)

-- Lua
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
        path = { '?.lua', '?/init.lua' },
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
          '${3rd}/luv/library',
          '${3rd}/busted/library',
          '${3rd}/luassert/library',
        }),
        checkThirdParty = 'Disable',
      },
    },
  },
})

-- JavaScript
require('lspconfig').ts_ls.setup({})
--  HTML
require('lspconfig').html.setup({})
-- latex
require('lspconfig').texlab.setup({})
-- VimScript
require('vimscript_ls')
-- julia
require('lspconfig').julials.setup({})

-- cmp config
local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- move to next candicate by Ctrl + n
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    -- move to previous candicate by Ctrl + p
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  }),
})

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
