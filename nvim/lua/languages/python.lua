local utl = require('languages.utl')

-- python
local pyright_config = {
  settings = {
    python = {
      pythonPath = './.venv/bin/python',
    },
  },
  on_attach = function(client, bufnr)
    print('use pyright')
    utl.navic.attach(client, bufnr)
  end,
}

local ty_config = {
  settings = {},
  on_attach = function(client, bufnr)
    print('use ty')
    utl.navic.attach(client, bufnr)
  end,
}

-- pyright or ty
if os.getenv('TY') then
  vim.lsp.config.ty = pyright_config
  vim.lsp.enable({ 'ty' })
else
  vim.lsp.config.pyright = pyright_config
  vim.lsp.enable({ 'pyright' })
end

require('formatter').setup({
  filetype = {
    python = {
      require('formatter.filetypes.python').ruff,
    },
  },
})
