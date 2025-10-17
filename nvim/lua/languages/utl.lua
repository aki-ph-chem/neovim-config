local M = {}

M.read_lsp_config = function(path_to_config, config)
  local ok, project_config = pcall(dofile, path_to_config)
  if ok then
    config = project_config
  end

  return config
end

M.merge_arrays = function(...)
  local tables_to_merge = { ... }
  local result = {}

  for _, t in ipairs(tables_to_merge) do
    table.move(t, 1, #t, #result + 1, result)
  end

  return result
end

M.navic = require('nvim-navic')
M.navic.setup {
  icons = {
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = ' ',
    Interface = ' ',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = ' ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = ' ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
  lsp = {
    auto_attach = true,
  },
  highlight = true,
  depth_limit = 9,
}
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

return M
