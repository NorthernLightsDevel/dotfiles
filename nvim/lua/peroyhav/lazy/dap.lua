return {
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "netcoredbg" },
		})
		require("dap").setup()
		require("dap-ui").setup()
	end,
}
