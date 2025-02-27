-- About Fern
-- j,k : cursor Up/Down l/h: open directory/ clse directory
-- Ctrl + m: open file
-- Ctrl + h: move to parent direcotry
-- Enter or e: open file
-- E: open file by split verticaly
-- toggle Fern by :Nt
vim.api.nvim_create_user_command('Mt', function()
  vim.cmd(':Fern . -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 0 })

-- open directory <dir> by :Ntt <dir>
vim.api.nvim_create_user_command('Mtt', function(opts)
  local dir = opts.args
  vim.cmd(':Fern ' .. dir .. ' -reveal=% -drawer -toggle -width=25<CR>')
end, { nargs = 1 })

-- Fern config
-- set font as nerdfont
-- vim.cmd[[let g:fern#renderer = 'nerdfont']]
-- show hidden file
vim.cmd([[let g:fern#default_hidden=1]])

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
    width = 30,
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
