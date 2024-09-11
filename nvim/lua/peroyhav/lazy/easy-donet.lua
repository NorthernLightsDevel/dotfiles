return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local function get_secret_path(secret_guid)
			local path = ""
			local home_dir = vim.fn.expand("~")
			if require("easy-dotnet").isWindows() then
				path = require("os").getenv("APPDATA")
					.. "\\Microsoft\\UserSecrets\\"
					.. secret_guid
					.. "\\secrets.json"
			else
				path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
			end
			return path
		end

		local dotnet = require("easy-dotnet")
		-- Options are not required
		dotnet.setup({
			--Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
			--get_sdk_path = get_sdk_path,
			---@type TestRunnerOptions
			test_runner = {
				---@type "split" | "float" | "buf"
				viewmode = "split",
				noBuild = true,
				noRestore = true,
			},
			---@param action "test" | "restore" | "build" | "run"
			terminal = function(path, action)
				local commands = {
					run = function()
						return "dotnet run --project " .. path
					end,
					test = function()
						return "dotnet test " .. path
					end,
					restore = function()
						return "dotnet restore " .. path
					end,
					build = function()
						return "dotnet build " .. path
					end,
				}
				local command = commands[action]() .. "\r"
				vim.cmd("vsplit")
				vim.cmd("term " .. command)
			end,
			secrets = {
				path = get_secret_path,
			},
			csproj_mappings = true,
			auto_bootstrap_namespace = true,
		})

		vim.keymap.set("n", "<C-F9>", dotnet.build_solution)
		vim.keymap.set("n", "<S-F10>", dotnet.run_default)
		vim.keymap.set("n", "<leader>rt", dotnet.test_solution)
	end,
}
