local dap = require('dap')
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- debugger config
dap.adapters = {
  codellsb = {
    type = 'sever',
    port = '${port}',
    exectable = {
      command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adpter/codelldb',
      args = { '--port', '${port}' },
    },
  },
}

dap.configurations = {
  cpp = {
    name = 'launch file',
    type = 'codelldb',
    request = 'launch',

    program = function()
      return vim.fn.input('Path to exectable: ', vim.fn.getcwd() .. '/', 'file')
    end,

    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
