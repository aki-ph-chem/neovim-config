-- resize window
-- +10 horizontal
-- stylua: ignore
vim.api.nvim_create_user_command("Ri", function()
    vim.cmd("resize +10")
end, { nargs = 0 })

-- -10 horizontal
-- stylua: ignore
vim.api.nvim_create_user_command("Rd", function()
    vim.cmd("resize -10")
end, { nargs = 0 })

-- +10 vertical
-- stylua: ignore
vim.api.nvim_create_user_command("Vi", function()
    vim.cmd("vertical resize +10")
end, { nargs = 0 })

-- -10 vertical
-- stylua: ignore
vim.api.nvim_create_user_command("Vd", function()
    vim.cmd("vertical resize -10")
end, { nargs = 0 })

-- +x vertical
-- stylua: ignore
vim.api.nvim_create_user_command("Vii", function(ops)
    vim.cmd("vertical resize +" .. ops.args)
end, { nargs = 1 })

-- +x vertical
-- stylua: ignore
vim.api.nvim_create_user_command("Vdd", function(ops)
    vim.cmd("vertical resize -" .. ops.args)
end, { nargs = 1 })

-- for cargo
vim.cmd([[command Car !cargo run]])
vim.cmd([[command Cab !cargo build]])
vim.cmd([[command Cat !cargo test]])

----- for `cargo run --bin ` ------
-- stylua: ignore
vim.api.nvim_create_user_command("Carbin", function(opts)
    local args = opts.args
    local cmd = "cargo run --bin " .. args
    local res_of_cmd = vim.fn.system(cmd)
    print(res_of_cmd)
end, { nargs = 1 })

----- for `cargo build --bin` -----
-- stylua: ignore
vim.api.nvim_create_user_command("Cabbin", function(opts)
    local args = opts.args
    local cmd = "cargo build --bin " .. args
    local res_of_cmd = vim.fn.system(cmd)
    print(res_of_cmd)
end, { nargs = 1 })

-- stylua: ignore
vim.api.nvim_create_user_command("Carbinl", function(opts)
    local args = opts.args
    local cmd = "cargo run --bin " .. args
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window & print result
    vim.cmd("vnew")
    for index, line in ipairs(res_of_cmd) do
        vim.fn.append(index, line)
    end
    vim.cmd("setlocal buftype=nofile")
end, { nargs = 1 })

--- for make --
-- stylua: ignore
vim.api.nvim_create_user_command("Makel", function(opts)
    local args = opts.args
    local cmd = "make " .. args
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window & print result
    vim.cmd("vnew")
    for index, line in ipairs(res_of_cmd) do
        vim.fn.append(index, line)
    end
    vim.cmd("setlocal buftype=nofile")
end, { nargs = 1 })

--- for make run file=<file name> --
-- stylua: ignore
vim.api.nvim_create_user_command("Mkr", function(opts)
    local args = opts.args
    local cmd = "make run file=" .. args
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window & print result
    vim.cmd("vnew")
    for index, line in ipairs(res_of_cmd) do
        vim.fn.append(index, line)
    end
    vim.cmd("setlocal buftype=nofile")
end, { nargs = 1 })

-- for go run <file name>
-- stylua: ignore
vim.api.nvim_create_user_command("Gr", function(opts)
    local cmd = "go run " .. opts.args .. ".go"
    local res_of_cmd = vim.fn.systemlist(cmd)

    -- open new window(buffer) & print result
    vim.cmd("vnew")
    for idx, line in ipairs(res_of_cmd) do
        vim.fn.append(idx, line)
    end
    vim.cmd("setlocal buftype=nofile")
end, { nargs = 1 })
