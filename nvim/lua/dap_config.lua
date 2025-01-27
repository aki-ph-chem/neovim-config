local dap = require('dap')
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- debugger config
dap.adapters = {
  codelldb = {
    type = 'executable',
    command = 'codelldb',
  },
}

dap.configurations = {
  cpp = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  },

  rust = {
    {
      name = 'Launch file',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  },
}
dap.configurations.c = dap.configurations.cpp

-- commands & keymap
-- Setting breakpoints
vim.api.nvim_create_user_command('B', function()
  vim.cmd("lua require'dap'.toggle_breakpoint()")
end, { nargs = 0 })

-- Luanching debug session and resuming execution
vim.api.nvim_create_user_command('C', function()
  vim.cmd("lua require'dap'.continue()")
end, { nargs = 0 })

-- Stepping through code
-- ref: ':help dap-mapping'
vim.keymap.set('n', '<C-i>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<C-o>', function()
  require('dap').step_over()
end)
