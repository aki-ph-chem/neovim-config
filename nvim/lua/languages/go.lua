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

-- formatter: Go
-- Utilities for creating configurations
local util = require('formatter.util')
require('formatter').setup({
  filetype = {
    go = {
      -- Go filetype
      require('formatter.filetypes.go').goimports,

      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == 'special.lua' then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = 'goimports',
          args = {
            '-w',
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
        }
      end,
    },
  },
})

-- format by save file
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- format by save *.go file
autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

-- format by save other file
augroup('__formatter__', { clear = true })
autocmd('BufWritePost', {
  group = '__formatter__',
  command = ':FormatWrite',
})
