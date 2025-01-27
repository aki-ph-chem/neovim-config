local dap = require('dap')
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- debugger config
dap.adapters = {
  codelldb = {
    type = 'executable',
    command = 'codelldb',
  },
  debugpy = {
    type = 'executable',
    command = vim.fn.getcwd() .. '/.venv/bin/python',
    args = { '-m', 'debugpy.adapter' },
    options = {
      source_filetype = 'python',
    },
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

  python = {
    {
      name = 'Launch file',
      type = 'debugpy',
      request = 'launch',
      program = '${file}',
      pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return '/usr/bin/python'
        end
      end,
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
