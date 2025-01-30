return {
  cmd = {
    'docker',
    'exec',
    '-i',
    'clangd_docker',
    'clangd',
    '--log=verbose',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=iwyu',
    '--suggest-missing-includes',
    '--cross-file-rename',
  },
}
