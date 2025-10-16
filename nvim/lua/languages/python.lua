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

local ruff_format = {
  formatCommand = 'ruff format --no-cache --stdin-filename  ${INPUT}',
  formatStdin = true,
  rootMarkers = {
    'pyproject.toml',
    'setup.py',
    'requirements.txt',
    'ruff.toml',
  },
}

local ruff_lint = {
  prefix = 'ruff',
  lintSource = 'efm/ruff',
  lintCommand = 'ruff check --quiet --output-format github --stdin-filename "${INPUT}',
  lintStdin = true,
  lintFormats = {
    '::%trror title=%.%#,file=%.%#,line=%.%#,col=%.%#,endLine=%.%#,endColumn=%.%#::%f:%l:%c: %m',
    '::%tarning title=%.%#,file=%.%#,line=%.%#,col=%.%#,endLine=%.%#,endColumn=%.%#::%f:%l:%c: %m',
  },
  lintSeverity = 2,
  rootMarkers = {
    'ruff.toml',
    'pyproject.toml',
    'setup.cfg',
  },
}

local languages = {
  python = { ruff_format, ruff_lint },
}

-- config for efm-langserver by vim.lsp.config
vim.lsp.config.efm = {
  cmd = { 'efm-langserver' },

  settings = {
    languages = languages,
  },

  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },

  filetypes = vim.tbl_keys(languages),
}

vim.lsp.enable({ 'efm' })

-- format by save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {
    '*.py',
  },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
