return {
	"mfussenegger/nvim-dap",
	"NicholasMata/nvim-dap-cs",
	config = function()
		require("dap").setup({
			callback = function(event)
				vim.keymap.set("n", "<F32>", require("dap").toggle_breakpoint)
			end,
		})
		require("dap-cs").setup()
	end,
}
