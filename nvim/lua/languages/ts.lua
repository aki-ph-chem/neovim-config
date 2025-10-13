local utl = require('languages.utl')

-- languages server
vim.lsp.config.ts_ls = {
  settings = {},
  on_attach = function(client, bufnr)
    utl.navic.attach(client, bufnr)
  end,
}
vim.lsp.enable({ 'ts_ls' })

-- config for Biome formatter
local biome_tool = {
  -- for Lint
  -- output Lint/Format result by `check` command as JSON format and analyze by efm-langserver
  lintCommand = 'biome check --apply-unsafe --format-kind json --stdin-file-path ${INPUT}',
  lintStdin = true,
  lintFormats = { '%f:%l:%c %m' },
  lintSource = 'Biome',
  lintIgnoreExitCode = true, -- DO NOT exit efm-langserver when ERROR

  -- for Format
  formatCommand = 'biome format --stdin-file-path ${INPUT} --skip-project',
  formatStdin = true,
}

-- config for efm-langserver by vim.lsp.config
vim.lsp.config.efm = {
  cmd = { 'efm-langserver' },

  settings = {
    languages = {
      javascript = { biome_tool },
      javascriptreact = { biome_tool },
      typescript = { biome_tool },
      typescriptreact = { biome_tool },
    },
    rootMarkers = {
      '.git/',
      'package.json',
      'biome.json',
    },
  },

  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    -- Lint
    documentDiagnostics = true,
    codeAction = true,
  },

  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
}

-- activate efm
vim.lsp.enable({ 'efm' })

-- format by save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {
    '*.js',
    '*.jsx',
    '*.ts',
    '*.tsx',
  },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
