return {
  cmd = {
    'docker',
    'exec',
    '-i',
    'rust_docker',
    '/usr/local/cargo/bin/rust-analyzer',
    '-v',
    '--log-file',
    '/rust-analyzer.log',
  },
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
    },
  },
}
