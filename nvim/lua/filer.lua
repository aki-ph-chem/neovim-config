-- nvim-tree.lua
local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
end

require('nvim-tree').setup({
  on_attach = my_on_attach,

  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})

-- toggle nvim-tree.lua by :Nt
vim.api.nvim_create_user_command('Nt', function()
  vim.cmd(':NvimTreeToggle<CR>')
end, { nargs = 0 })
