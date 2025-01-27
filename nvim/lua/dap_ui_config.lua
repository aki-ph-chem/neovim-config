local dap_ui = require('dapui')
-- ref: https://ryota2357.com/blog/2022/cpp-codelldb-debug-nvim/
dap_ui.setup({
  icons = { expanded = '', collapsed = '' },
  layouts = {
    {
      elements = {
        { id = 'repl', size = 0.15 },
        { id = 'stacks', size = 0.2 },
        { id = 'watches', size = 0.2 },
        { id = 'scopes', size = 0.35 },
        { id = 'breakpoints', size = 0.1 },
      },
      size = 0.4,
      position = 'left',
    },
    {
      elements = { 'console' },
      size = 0.25,
      position = 'bottom',
    },
  },
})

-- open / close ui windows automatically
local dap = require('dap')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dap_ui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dap_ui.close()
end

-- toggle dap-ui
vim.api.nvim_create_user_command('Dui', function()
  dap_ui.toggle()
end, { nargs = 0 })
