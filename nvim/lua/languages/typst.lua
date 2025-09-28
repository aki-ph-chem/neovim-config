-- for Typst
-- ref: https://myriad-dreamin.github.io/tinymist/frontend/neovim.html
vim.lsp.config.tinymist = {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
  },
}
vim.lsp.enable({ 'tinymist' })
