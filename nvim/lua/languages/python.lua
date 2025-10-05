local utl = require('languages.utl')

-- python
local pyright_config = {
  settings = {
    python = {
      pythonPath = './.venv/bin/python',
    },
  },
  on_attach = function(client, bufnr)
    local current_dir = vim.fn.getcwd()
    vim.env.PATH = current_dir .. '/.venv/bin:' .. vim.env.PATH
    vim.env.VIRTUAL_ENV = current_dir .. '/.venv'
    utl.navic.attach(client, bufnr)
  end,
}

-- pyright
vim.lsp.config.pyright = pyright_config
vim.lsp.enable({ 'pyright' })

require('formatter').setup({
  filetype = {
    python = {
      require('formatter.filetypes.python').ruff,
    },
  },
})
