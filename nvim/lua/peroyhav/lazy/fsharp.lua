-- plugins/roslyn.lua (Lazy spec)
return {
	"neovim/nvim-lspconfig",
	ft = { "fsharp" }, -- C#, Visual Basic
	config = function()
		vim.filetype.add({
			extension = { fs = "fsharp", fsx = "fsharp", fsi = "fsharp" },
		})

		require("lspconfig").fsautocomplete.setup({
			on_attach = require("lsp.on_attach"),
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
