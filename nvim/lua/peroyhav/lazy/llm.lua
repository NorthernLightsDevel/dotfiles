return {
	"Kurama622/llm.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
	config = function()
		require("llm").setup({
			url = "https://localhost:11434/v1/chat/completions",
			model = "qwen2.5-coder:7b",
			api_type = "ollama",
		})
	end,
	keys = {
		{ "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
	},
}
