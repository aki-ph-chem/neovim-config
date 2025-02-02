return {
  cmd = vim.lsp.rpc.connect('127.0.0.1', 27631),
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      lspMux = {
        version = '1',
        method = 'connect',
        server = 'rust-analyzer',
      },
    },
  },
}
