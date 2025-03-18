-- resize window
-- +10 horizontal
vim.api.nvim_create_user_command('Ri', function()
  vim.cmd('resize +10')
end, { nargs = 0 })

-- -10 horizontal
vim.api.nvim_create_user_command('Rd', function()
  vim.cmd('resize -10')
end, { nargs = 0 })

-- +x horizontal
vim.api.nvim_create_user_command('Rii', function(ops)
  vim.cmd('resize +' .. ops.args)
end, { nargs = 1 })

-- -x horizontal
vim.api.nvim_create_user_command('Rdd', function(ops)
  vim.cmd('resize -' .. ops.args)
end, { nargs = 1 })

-- +10 vertical
vim.api.nvim_create_user_command('Vi', function()
  vim.cmd('vertical resize +10')
end, { nargs = 0 })

-- -10 vertical
vim.api.nvim_create_user_command('Vd', function()
  vim.cmd('vertical resize -10')
end, { nargs = 0 })

-- +x vertical
vim.api.nvim_create_user_command('Vii', function(ops)
  vim.cmd('vertical resize +' .. ops.args)
end, { nargs = 1 })

-- -x vertical
vim.api.nvim_create_user_command('Vdd', function(ops)
  vim.cmd('vertical resize -' .. ops.args)
end, { nargs = 1 })

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- config of Terminal & ToggleTerm
require('toggleterm').setup({
  size = 23,
})
map('t', '<Esc>', '<C-\\><C-n>')

vim.api.nvim_create_user_command('Tt', function()
  vim.cmd('ToggleTerm')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Th', function()
  vim.cmd('ToggleTerm direction=horizontal')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Tf', function()
  vim.cmd('ToggleTerm direction=float')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Tv', function()
  vim.cmd('ToggleTerm size=60 direction=vertical')
end, { nargs = 0 })

-- for cargo
vim.cmd([[command Car !cargo run]])
vim.cmd([[command Cab !cargo build]])
vim.cmd([[command Cat !cargo test]])

----- for `cargo run --bin ` ------
vim.api.nvim_create_user_command('Carbin', function(opts)
  local args = opts.args
  local cmd = 'cargo run --bin ' .. args
  local res_of_cmd = vim.fn.system(cmd)
  print(res_of_cmd)
end, { nargs = 1 })

----- for `cargo build --bin` -----
vim.api.nvim_create_user_command('Cabbin', function(opts)
  local args = opts.args
  local cmd = 'cargo build --bin ' .. args
  local res_of_cmd = vim.fn.system(cmd)
  print(res_of_cmd)
end, { nargs = 1 })

vim.api.nvim_create_user_command('Carbinl', function(opts)
  local args = opts.args
  local cmd = 'cargo run --bin ' .. args
  local res_of_cmd = vim.fn.systemlist(cmd)

  -- open new window & print result
  vim.cmd('vnew')
  for index, line in ipairs(res_of_cmd) do
    vim.fn.append(index, line)
  end
  vim.cmd('setlocal buftype=nofile')
end, { nargs = 1 })

--- for make --
vim.api.nvim_create_user_command('Makel', function(opts)
  local args = opts.args
  local cmd = 'make ' .. args
  local res_of_cmd = vim.fn.systemlist(cmd)

  -- open new window & print result
  vim.cmd('vnew')
  for index, line in ipairs(res_of_cmd) do
    vim.fn.append(index, line)
  end
  vim.cmd('setlocal buftype=nofile')
end, { nargs = 1 })

--- for make run file=<file name> --
vim.api.nvim_create_user_command('Mkr', function(opts)
  local args = opts.args
  local cmd = 'make run file=' .. args
  local res_of_cmd = vim.fn.systemlist(cmd)

  -- open new window & print result
  vim.cmd('vnew')
  for index, line in ipairs(res_of_cmd) do
    vim.fn.append(index, line)
  end
  vim.cmd('setlocal buftype=nofile')
end, { nargs = 1 })

-- for go run <file name>
vim.api.nvim_create_user_command('Gr', function(opts)
  local cmd = 'go run ' .. opts.args .. '.go'
  local res_of_cmd = vim.fn.systemlist(cmd)

  -- open new window(buffer) & print result
  vim.cmd('vnew')
  for idx, line in ipairs(res_of_cmd) do
    vim.fn.append(idx, line)
  end
  vim.cmd('setlocal buftype=nofile')
end, { nargs = 1 })

local get_current_file_path = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return nil
  end

  return current_file
end

--- for Google-Chrome ---
local open_file_by_chrome = function(path)
  local cmd = { 'google-chrome-stable', path }
  vim.fn.jobstart(cmd, {
    on_stderr = function(_, data, _)
      print('Error:', data)
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print('Chrome opened succesfully')
      else
        print('Failed to open Chrome')
      end
    end,
  })
end

vim.api.nvim_create_user_command('Mkd', function()
  local path_to_mardown = get_current_file_path()

  if path_to_mardown then
    open_file_by_chrome(path_to_mardown)
  end
end, { nargs = 0 })

local open_file_by_pgopher = function(path)
  local cmd = { 'pgopher', path }
  vim.fn.jobstart(cmd, {
    on_stderr = function(_, data, _)
      print('Error:', data)
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print('PGOPHER opened succesfully')
      else
        print('Failed to open PGOPHER')
      end
    end,
  })
end

--- for PGOPHER ---
vim.api.nvim_create_user_command('Pgf', function()
  local path_to_mardown = get_current_file_path()

  if path_to_mardown then
    open_file_by_pgopher(path_to_mardown)
  end
end, { nargs = 0 })

--- for LaTex by llmk  ---
local build_latex = { 'llmk' }
--- build by ':Lm'
vim.api.nvim_create_user_command('Lm', function()
  vim.fn.jobstart(build_latex, {
    on_stderr = function(_, data, _)
      print('Error:', data)
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print('build by llmk ok!')
      else
        print('Failed to build by llmk see *.log file')
      end
    end,
  })
end, { nargs = 0 })

--- build by save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  callback = function()
    vim.fn.jobstart(build_latex, {
      on_stderr = function(_, data, _)
        print('Error:', data)
      end,
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          print('build by llmk ok!')
        else
          print('Failed to build by llmk see *.log file')
        end
      end,
    })
  end,
})

-- BibTeX
vim.api.nvim_create_user_command('Bb', function(opts)
  local cmd = { 'bibtex', opts.args }
  vim.fn.jobstart(cmd, {
    on_stderr = function(_, data, _)
      print('Error:', data)
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print('bibtex ok!')
      else
        print('Failed to run bibtex')
      end
    end,
  })
end, { nargs = 1 })
