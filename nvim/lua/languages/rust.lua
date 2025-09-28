local utl = require('languages.utl')

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
    utl.navic.attach(client, bufnr)
  end,
}

-- rust-analyzer
rust_analyzer_config = utl.read_lsp_config(vim.fn.getcwd() .. '/rust_analyzer_config.lua', rust_analyzer_config)
vim.lsp.config.rust_analyzer = rust_analyzer_config
vim.lsp.enable({ 'rust_analyzer' })

-- for rustfmt
vim.g.rustfmt_autosave = 1
