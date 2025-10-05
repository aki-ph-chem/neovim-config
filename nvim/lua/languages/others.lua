-- Nix Language
vim.lsp.config.nil_ls = {
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
}
vim.lsp.enable({ 'nil_ls' })

-- Teal
vim.lsp.config.teal_ls = {}
vim.lsp.enable({ 'teal_ls' })

--  HTML
vim.lsp.config.html = {}
vim.lsp.enable({ 'html' })

-- julia
vim.lsp.config.julials = {}
vim.lsp.enable({ 'julials' })
