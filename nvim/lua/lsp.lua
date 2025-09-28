-- LSP config
local home_dir = vim.env.HOME
-- depend on Python
vim.env.PATH = home_dir .. '/neovim-config/.venv/bin:' .. vim.env.PATH
-- depend on Node.js
vim.env.PATH = home_dir .. '/neovim-config/node_modules/.bin:' .. vim.env.PATH
-- teal-language-server
-- installed by below
--[[
$ luarocks install --tree ./.lua_modules teal-language-server
--]]
vim.env.PATH = home_dir .. '/neovim-config/.lua_modules/bin:' .. vim.env.PATH

-- lsp for log
local use_lsp_log_debug = false
if use_lsp_log_debug then
  vim.lsp.set_log_level('debug')
end
--- jump to definition by 'gd'
vim.keymap.set('n', 'gd', function()
  vim.lsp.buf.definition()
end)

-- hover
vim.keymap.set('n', 'gh', function()
  vim.lsp.buf.hover()
end)

-- show ref all
vim.keymap.set('n', 'gr', function()
  vim.lsp.buf.references()
end)

-- rename all
vim.keymap.set('n', 'gn', function()
  vim.lsp.buf.rename()
end)

-- list up all symobl in current buffer
vim.keymap.set('n', 'gl', function()
  vim.lsp.buf.document_symbol()
end)

-- list up all symobl in all buffers
vim.keymap.set('n', 'ga', function()
  vim.lsp.buf.workspace_symbol()
end)

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
vim.lsp.config.pyright = pyright_config
vim.lsp.enable({ 'pyright' })

-- clangd
clangd_config = read_lsp_config(vim.fn.getcwd() .. '/clangd_config.lua', clangd_config)
vim.lsp.config.clangd = clangd_config
vim.lsp.enable({ 'clangd' })

-- CMake
vim.lsp.config.cmake = {}
vim.lsp.enable({ 'cmake' })

-- for rustfmt
vim.g.rustfmt_autosave = 1

-- rust-analyzer
rust_analyzer_config = read_lsp_config(vim.fn.getcwd() .. '/rust_analyzer_config.lua', rust_analyzer_config)
vim.lsp.config.rust_analyzer = rust_analyzer_config
vim.lsp.enable({ 'rust_analyzer' })

-- go lang
vim.lsp.config.gopls = gols_config
vim.lsp.enable({ 'gopls' })

-- Nix Language
vim.lsp.config.nil_ls = {}
vim.lsp.enable({ 'nil_ls' })

-- Teal
vim.lsp.config.teal_ls = {}
vim.lsp.enable({ 'teal_ls' })

-- JavaScript
vim.lsp.config.ts_ls = {}
vim.lsp.enable({ 'ts_ls' })

--  HTML
vim.lsp.config.html = {}
vim.lsp.enable({ 'html' })

-- VimScript
require('vimscript_ls')

-- julia
vim.lsp.config.julials = {}
vim.lsp.enable({ 'julials' })

-- for cmp-spell
-- add word to black list: zg
-- reflect the list(en.utf-8.add) in the en.utf-8.add.spl: :mkspell! ~/.config/nvim/spell/en.utf-8.add
-- activate source for cmp in *.tex file
local spell_check_cfg = {
  name = 'spell',
  option = {
    keep_all_entries = false,
    enable_in_context = function()
      return true
    end,
    preselect_correct_word = true,
  },
}

-- activate spell-check in *.tex file
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.tex' },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = { 'en_us' }
  end,
})
--spell_check_cfg = {}
-- if you switch spell check
-- you can do by below:
-- `:lua vim.opt.spell = not vim.opt.spell`

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
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
  }),
  sources = cmp.config.sources({
    {
      name = 'nvim_lsp',
      option = {
        markdown_oxide = {
          keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
        },
      },
    },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'skkeleton' },
    spell_check_cfg,
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

-- pop up the results from LSP
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- set 300ms for CursorHold
vim.o.updatetime = 300
