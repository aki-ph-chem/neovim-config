local opt = vim.opt

opt.mouse = 'a' 
opt.title = true
opt.number = true
opt.clipboard = "unnamedplus" 
opt.smartindent = true
opt.shiftwidth = 4
--opt.syntax = true

--- for key map
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i','jj','<Esc>')
