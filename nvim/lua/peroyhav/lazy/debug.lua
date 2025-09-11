return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
		"NicholasMata/nvim-dap-cs",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"delve",
				"netcoredbg",
			},
		})

		-- nvim-dap-cs setup
		require("dap-cs").setup()

		vim.defer_fn(function()
			if dap.configurations.cs then
				for _, config in ipairs(dap.configurations.cs) do
					config.preLaunchTask = {
						task = "build",
						type = "shell",
						command = "dotnet",
						args = { "build" },
					}
				end
			end
		end, 100)

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		vim.keymap.set("n", "<S-F9>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<S-F7>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<S-F8>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open

		require("dap-go").setup({
			delve = {
				detached = vim.fn.has("win32") == 0,
			},
		})

		dap.listeners.before.event_module["preLaunchTask"] = function(session, body, command)
			error(body)
			local task = body.task
			if task.type == "shell" then
				local command = table.concat(vim.tbl_flatten({ task.command, task.args }), " ")
				print("Running pre-launch task: " .. command)
				local result = vim.fn.system(command)
				if vim.v.shell_error ~= 0 then
					error("Pre-launch task: " .. command .. " failed.")
				end
				return result
			end
		end
	end,
}
