local M = {}

M.on_save = function()
  local project_dir_prev_session = vim.fn.getcwd()
  return { project_dir = project_dir_prev_session }
end

M.on_post_load = function(data)
  print('data.project_dir = ' .. data.project_dir)
  --vim.api.nvim_set_current_dir(data.project_dir)
  --vim.system({ 'direnv', 'export', 'vim' }, { text = true, cwd = data.porject_dir }, on_exit)

  --[[
  vim.b.direnv_autoload_triggered = true
  vim.defer_fn(function()
    vim.b.direnv_autoload_triggered = false
  end, 1000)
  --]]
end

return M
