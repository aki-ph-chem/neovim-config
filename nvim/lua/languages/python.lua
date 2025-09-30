local utl = require('languages.utl')

local current_dir = vim.fn.getcwd()
vim.env.PATH = current_dir .. '/.venv/bin:' .. vim.env.PATH
vim.env.VIRTUAL_ENV = current_dir .. '/.venv'

-- python
local pyright_config = {
  settings = {
    python = {
      pythonPath = './.venv/bin/python',
    },
  },
  on_attach = function(client, bufnr)
    utl.navic.attach(client, bufnr)
  end,
}

-- pyright
vim.lsp.config.pyright = pyright_config
vim.lsp.enable({ 'pyright' })
