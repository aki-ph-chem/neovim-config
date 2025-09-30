-- Go
local gols_config = {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- go lang
vim.lsp.config.gopls = gols_config
vim.lsp.enable({ 'gopls' })
