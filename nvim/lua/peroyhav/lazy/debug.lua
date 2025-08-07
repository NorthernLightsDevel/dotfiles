-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"leoluz/nvim-dap-go",
		"NicholasMata/nvim-dap-cs",
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			-- Basic debugging keymaps, feel free to change to your liking!
			{ "<S-F9>", dap.continue, desc = "Debug: Start/Continue" },
			{ "<F7>", dap.step_into, desc = "Debug: Step Into" },
			{ "<F8>", dap.step_over, desc = "Debug: Step Over" },
			{ "<S-F7>", dap.step_out, desc = "Debug: Step Out" },
			{ "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
			{
				"<leader>B",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ "<S-F8>", dapui.toggle, desc = "Debug: See last session result." },
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
				"netcoredbg",
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
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

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
			},
		})
		function get_project_root()
			local current_file = vim.api.nvim_buf_get_name(0)
			if not current_file then
				error("Could not determine current file.")
			end
			local current_dir = vim.fn.fnamemodify(current_file, ":p:h")
			local Path = require("plenary.path")
			if not Path then
				error("Could not load plenary.path")
			end
			local path = Path:new(current_dir)

			while true do
				local project_files = vim.fn.glob(path:absolute() .. "/*.{csproj,sln}", false, true)
				if #project_files > 0 then
					return path:absolute()
				end

				local parent = path:parent()
				if parent:absolute() == path:absolute() then
					return nil
				end
				path = parent
			end
		end
		function get_project_file(project_root)
			local csproj_files = vim.fn.glob(project_root .. "/*.csproj", false, true)
			if #csproj_files > 0 then
				return csproj_files[1]
			end
			local sln_files = vim.fn.glob(project_root .. "/*.sln", false, true)
			if #sln_files > 0 then
				return sln_files[1]
			end
			return nil
		end
		function get_dotnet_project_file(project_root)
			local project_file = get_project_file(project_root)
			if not project_file then
				error("Could not locate project file in " .. project_root)
			end
		end
		function get_dotnet_executable()
			local project_root = get_project_root()
			if not project_root then
				error("Could not find project root(no .csproj or .sln found in path)")
			end
			local project_file = get_dotnet_project_file(project_root)
			local project_name = vim.fn.fnamemodify(project_file, ":t:r")
			local debug_path = vim.fn.glob(project_root .. "/bin/Debug/net*", false, true)
			if #debug_path == 0 then
				error("Project not compiled, please build " .. project_file)
			end

			local filename = debug_path[1] .. "/" .. project_name
			if not filename then
				error("not able to create filename")
			end

			if vim.fn.filereadable(filename) then
				return filename
			end

			if vim.fn.filereadable(filename .. ".exe") then
				return filename .. ".exe"
			end

			if vim.fn.filereadable(filename .. ".dll") then
				return filename .. ".dll"
			end

			error("No file matcing " .. filename .. "(.exe|.dll)? found")
		end

		print(vim.api.nvim_buf_get_name(0))
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch",
				preLaunchTask = {
					task = "build",
					type = "shell",
					command = "dotnet",
					args = {
						"build",
						get_project_file(get_project_root()),
					},
				},
				program = function()
					return get_dotnet_executable()
				end,
			},
		}
	end,
}
