local utl = require('languages.utl')

-- languages server
vim.lsp.config.ts_ls = {
  settings = {},
  on_attach = function(client, bufnr)
    utl.navic.attach(client, bufnr)
  end,
}
vim.lsp.enable({ 'ts_ls' })

require('formatter').setup({
  filetype = {
    javascript = { require('formatter.filetypes.javascript').biome },
    javascriptreact = { require('formatter.filetypes.javascriptreact').biome },
    typescript = { require('formatter.filetypes.typescript').biome },
    typescriptreact = { require('formatter.filetypes.typescriptreact').biome },
  },
})
