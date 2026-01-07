local M = {}

M.on_save = function()
  local project_dir_prev_session = vim.fn.getcwd()
  return { project_dir = project_dir_prev_session }
end

M.on_post_load = function(data)
  print(string.format('move to project dir: %s', data.project_dir))
  require('direnv-nvim').hook()
end

return M
