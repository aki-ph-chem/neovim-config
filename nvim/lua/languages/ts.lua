local utl = require('languages.utl')

-- languages server
vim.lsp.config.ts_ls = {
  settings = {},
  on_attach = function(client, bufnr)
    utl.navic.attach(client, bufnr)
  end,
}
vim.lsp.enable({ 'ts_ls' })

local use_efm = true

if not use_efm then
  require('formatter').setup({
    filetype = {
      javascript = { require('formatter.filetypes.javascript').biome },
      javascriptreact = { require('formatter.filetypes.javascriptreact').biome },
      typescript = { require('formatter.filetypes.typescript').biome },
      typescriptreact = { require('formatter.filetypes.typescriptreact').biome },
    },
  })
end

if use_efm then
  -- config for Biome formatter
  local biome_formatter = {
    formatCommand = 'biome format --stdin-file-path ${INPUT} --skip-project',
    formatStdin = true,
  }

  -- config for efm-langserver by vim.lsp.config
  vim.lsp.config.efm = {
    cmd = { 'efm-langserver' },

    settings = {
      languages = {
        javascript = { biome_formatter },
        javascriptreact = { biome_formatter },
        typescript = { biome_formatter },
        typescriptreact = { biome_formatter },
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
end
