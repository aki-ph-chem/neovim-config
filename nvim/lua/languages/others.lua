-- Nix Language
vim.lsp.config.nil_ls = {
  settings = {},
  root_markers = { 'flake.nix', '.git' },
}
vim.lsp.enable({ 'nil_ls' })

require('formatter').setup({
  filetype = {
    nix = {
      require('formatter.filetypes.nix').nixfmt,
    },
  },
})

-- Teal
vim.lsp.config.teal_ls = {}
vim.lsp.enable({ 'teal_ls' })

--  HTML
vim.lsp.config.html = {}
vim.lsp.enable({ 'html' })

-- julia
vim.lsp.config.julials = {}
vim.lsp.enable({ 'julials' })

-- asm
vim.lsp.asm_lsp = {}
vim.lsp.enable({ 'asm_lsp' })

-- Toml
vim.lsp.tombi = {
  cmd = {
    'tombi',
    'lsp',
  },
  filetypes = { 'toml' },
  root_markers = { 'tombi.toml', 'pyproject.toml', 'Cargo.toml', '.git' },
}
vim.lsp.enable({ 'tombi' })

-- format via LSP
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.toml' },
  callback = function()
    vim.lsp.buf.format({})
  end,
})
