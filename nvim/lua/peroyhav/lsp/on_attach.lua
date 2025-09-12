-- ~/.config/nvim/lua/peroyhav/lsp/on_attach.lua
local M = {}

function M.setup(client, bufnr)
	local buf = vim.lsp.buf
	local map = vim.keymap.set
	local opts = { buffer = bufnr, silent = true, noremap = true }

	map("n", "K", buf.hover, opts)
	map("n", "gd", buf.definition, opts)
	map("n", "gi", buf.implementation, opts)
	map("n", "gr", buf.references, opts)
	map("n", "<F2>", buf.rename, opts)
	map("n", "<leader>ca", buf.code_action, opts)
	map("n", "[d", vim.diagnostic.goto_prev, opts)
	map("n", "]d", vim.diagnostic.goto_next, opts)
end

return M
