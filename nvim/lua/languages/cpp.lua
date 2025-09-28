local utl = require('languages.utl')

-- cpp
local clangd_config = {
  cmd = {
    'clangd',
    '--log=verbose',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--suggest-missing-includes',
    '--cross-file-rename',
  },
  on_attach = function(client, bufnr)
    utl.navic.attach(client, bufnr)
  end,
}

-- clangd
clangd_config = utl.read_lsp_config(vim.fn.getcwd() .. '/clangd_config.lua', clangd_config)
vim.lsp.config.clangd = clangd_config
vim.lsp.enable({ 'clangd' })

-- CMake
vim.lsp.config.cmake = {}
vim.lsp.enable({ 'cmake' })
