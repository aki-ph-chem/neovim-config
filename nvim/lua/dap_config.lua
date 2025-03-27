local dap = require('dap')
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- debugger config
dap.adapters = {
  codelldb = {
    type = 'executable',
    command = 'codelldb',
  },
  gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
  },
  debugpy = {
    type = 'executable',
    command = vim.fn.getcwd() .. '/.venv/bin/python',
    args = { '-m', 'debugpy.adapter' },
    options = {
      source_filetype = 'python',
    },
  },
  debugpy_tcp = {
    type = 'server',
    port = assert('5678', '`connect.port` is required for a python `attach` configuration'),
    host = '127.0.0.1',
    options = {
      source_filetype = 'python',
    },
  },
}

dap.configurations = {
  cpp = {
    {
      name = 'Launch file by codelldb',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
    {
      name = 'Launch file by gdb',
      type = 'gdb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtBeginningOfMainSubprogram = false,
    },
    {
      name = 'Launch file by gdb with args',
      type = 'gdb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      args = function()
        local input = vim.fn.input('Args: ')
        return vim.split(input, ' ')
      end,
      cwd = '${workspaceFolder}',
      stopAtBeginningOfMainSubprogram = false,
    },
  },

  rust = {
    {
      name = 'Launch file by codelldb',
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
      name = 'Launch file by debugpy',
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
    {
      name = 'Launch file by debugpy_tcp',
      type = 'debugpy_tcp',
      request = 'attach',
      program = '${file}',
      pythonPath = function()
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

local read_dap_config = function(config, path_to_config)
  local ok, project_config = pcall(dofile, path_to_config)
  if ok then
    table.insert(config, project_config)
  end
end

read_dap_config(dap.configurations.cpp, vim.fn.getcwd() .. '/dap_cpp.lua')

dap.configurations.c = dap.configurations.cpp

-- commands & keymap
-- Setting breakpoints
vim.api.nvim_create_user_command('B', function()
  require('dap').toggle_breakpoint()
end, { nargs = 0 })

-- ref: ':help dap-user-commands', ':help dap-api'
-- clearn all breakpoints
vim.api.nvim_create_user_command('Bc', function()
  require('dap').clear_breakpoints()
end, { nargs = 0 })

-- Luanching debug session and resuming execution
vim.api.nvim_create_user_command('C', function()
  require('dap').continue()
end, { nargs = 0 })

-- relaunch current session
vim.api.nvim_create_user_command('Cr', function()
  require('dap').restart()
end, { nargs = 0 })

-- terminate current session
vim.api.nvim_create_user_command('Ct', function()
  require('dap').terminate()
end, { nargs = 0 })

-- Stepping through code
-- ref: ':help dap-mapping', ':help dap-api'
vim.keymap.set('n', '<C-i>', function()
  require('dap').step_into()
end)
vim.keymap.set('n', '<C-o>', function()
  require('dap').step_over()
end)
vim.keymap.set('n', '<C-k>', function()
  require('dap').step_out()
end)

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })
