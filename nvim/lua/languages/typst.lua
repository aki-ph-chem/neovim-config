-- for Typst
-- ref: https://myriad-dreamin.github.io/tinymist/frontend/neovim.html
vim.lsp.config.tinymist = {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  settings = {
    exportPdf = 'onType',
    semanticTokens = 'disable',
  },
}
vim.lsp.enable({ 'tinymist' })

-- for typstyle
require('formatter').setup {
  filetype = {
    typst = {
      function()
        return {
          exe = 'typstyle',
          args = {},
          stdin = true,
        }
      end,
    },
  },
}
