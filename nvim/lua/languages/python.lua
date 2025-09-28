local utl = require('languages.utl')

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
