-- latex
-- Ref: https://github.com/latex-lsp/texlab/wiki/Configuration
vim.lsp.config.texlab = {
  settings = {
    texlab = {
      --[[
      build = {
        executable = 'llmk',
        args = {},
        onSave = true,
        forwardSearchAfter = false,
      },
      --]]
      forwardSearch = {
        executable = 'qpdfview',
        args = { '--unique', '%p#src:%f:%l:1' },
      },
    },
  },
}
vim.lsp.enable({ 'texlab' })

--- for LaTex by llmk  ---
local build_latex = { 'llmk' }
--- build by ':Lm'
vim.api.nvim_create_user_command('Lm', function()
  vim.system(build_latex, { text = true }, function(result)
    if result.code == 0 then
      print('build by llmk ok')
    else
      print('Failed to build by llmk see *.log file')
    end
  end)
end, { nargs = 0 })

--- build by save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.tex', '*.bib' },
  callback = function()
    vim.system(build_latex, { text = true }, function(result)
      if result.code == 0 then
        print('build by llmk ok')
      else
        print('Failed to build by llmk see *.log file')
      end
    end)
  end,
})

-- BibTeX
vim.api.nvim_create_user_command('Bb', function(opts)
  local cmd = { 'bibtex', opts.args }
  vim.system(cmd, { text = true }, function(result)
    if result.code == 0 then
      print('bibtex ok!')
    else
      print('Failed to run bibtex')
    end
  end)
end, { nargs = 1 })
