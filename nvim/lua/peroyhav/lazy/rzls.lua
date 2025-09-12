-- plugins/rzls.lua (Lazy spec)
return {
	"seblyng/roslyn.nvim", -- keep Roslyn as the main plugin
	ft = { "cs", "vb", "razor" }, -- razor will be set for .cshtml/.razor below
	dependencies = {
		{
			"tris203/rzls.nvim",
			config = true, -- exposes rzls.roslyn_handlers
		},
	},
	init = function()
		-- Map file extensions before plugin loads so buffers get correct ft
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
	end,
	config = function()
		local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")
		-- Use Mason-provided Roslyn shim ("roslyn") and pass rzls integration flags
		local cmd = {
			"roslyn",
			"--stdio",
			"--logLevel=Information",
			"--extensionLogDirectory=" .. vim.fn.fnamemodify(vim.lsp.get_log_path(), ":h"),
			"--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
			"--razorDesignTimePath="
				.. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
			"--extension",
			vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
		}

		require("roslyn").setup({
			cmd = cmd,
			broad_search = true,
			config = {
				on_attach = require("peroyhav.lsp.on_attach"),
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- critical: wire rzls handlers into Roslyn so Razor features work
				handlers = require("rzls.roslyn_handlers"),
			},
		})
	end,
}
