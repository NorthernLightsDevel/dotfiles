-- plugins/roslyn.lua (Lazy spec)
return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.filetype.add({
			extension = { fs = "fsharp", fsx = "fsharp", fsi = "fsharp" },
		})

		require("lspconfig").fsautocomplete.setup({
			on_attach = require("peroyhav.lsp.on_attach").setup,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
