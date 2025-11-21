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

-- config of Terminal & ToggleTerm
require('toggleterm').setup({
  size = 23,
})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.api.nvim_create_user_command('Tt', function()
  vim.cmd('ToggleTerm')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Thn', function()
  vim.cmd('TermNew size=20 direction=horizontal')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Tf', function()
  vim.cmd('TermNew direction=float')
end, { nargs = 0 })

vim.api.nvim_create_user_command('Tvn', function()
  vim.cmd('TermNew size=60 direction=vertical')
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

local open_file_by_pgopher = function(path)
  local cmd = { 'pgopher', path }
  vim.system(cmd, { text = true }, function(result)
    if result.code == 0 then
      print('PGOPHER opend succesfully')
    else
      print('Error: ' .. result.stderr)
    end
  end)
end

--- for PGOPHER ---
vim.api.nvim_create_user_command('Pgf', function()
  local path_to_mardown = get_current_file_path()

  if path_to_mardown then
    open_file_by_pgopher(path_to_mardown)
  end
end, { nargs = 0 })

-- open *.pdf file by Zathura or other
vim.env.PUBS = vim.env.HOME .. '/.pubs/doc'

vim.api.nvim_create_user_command('Pdf', function(opts)
  local path_args = opts.args
  local path = string.gsub(path_args, '~', vim.env.HOME)
  path = string.gsub(path, '$PUBS', vim.env.PUBS)

  -- if you set PDF_READER='qpdfview' the value of pdf_reader is qpdfview
  local pdf_reader = os.getenv('PDF_READER') and os.getenv('PDF_READER') or 'zathura'

  local cmd = { pdf_reader, path }
  vim.system(cmd, { text = true }, function(_) end)
end, { nargs = 1 })

--[[
## memo to call external commands

- ref
    - https://neovim.io/doc/user/lua.html#vim.system()
    - https://neovim.io/doc/user/luvref.html#uv.spawn()
    - https://neovim.io/doc/user/job_control.html
    - https://neovim.io/doc/user/lua.html#vim.rpcnotify()

- External command invocation => vim.system() or vim.uv.spawn(), the latter is a lower-level API
- Messge Pack RPC => vim.fn.jobstart() or vim.rpcnotify(), the latter is a newer API, the former is more legacy

--]]
