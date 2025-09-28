-- for markdown-oxide
-- An example nvim-lspconfig capabilities setting
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config.markdown_oxide = {
  -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
  -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
  capabilities = vim.tbl_deep_extend('force', capabilities, {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }),
  --on_attach = on_attach, -- configure your on attach config
}
vim.lsp.enable({ 'markdown_oxide' })

--- for Google-Chrome ---
local open_file_by_chrome = function(path)
  local cmd = { 'google-chrome-stable', path }
  vim.system(cmd, { text = true }, function(result)
    if result.code == 0 then
      print('Chrome opend succesfully: ' .. result.stdout)
    else
      print('Error: ' .. result.stderr)
    end
  end)
end

local open_file_by_chromium = function(path)
  local cmd = { 'chromium', path }
  vim.system(cmd, { text = true }, function(result)
    if result.code == 0 then
      print('Chrome opend succesfully: ' .. result.stdout)
    else
      print('Error: ' .. result.stderr)
    end
  end)
end

local get_current_file_path = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return nil
  end

  return current_file
end

vim.api.nvim_create_user_command('Mkd', function()
  local path_to_mardown = get_current_file_path()

  if path_to_mardown then
    open_file_by_chromium(path_to_mardown)
  end
end, { nargs = 0 })
