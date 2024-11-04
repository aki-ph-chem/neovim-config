-- VimScript
local path_to_vimscript_ls = "/home/aki/vimscript-language-server/target/release/vimscript-language-server"
local is_debug = false

if is_debug then
	path_to_vimscript_ls = "/home/aki/vimscript-language-server/target/debug/vimscript-language-server"
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "vim" },
	callback = function()
		vim.lsp.start({
			name = "vimscript-language-sever",
			cmd = {
				path_to_vimscript_ls,
			},
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		})
	end,
})
