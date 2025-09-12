-- plugins/roslyn.lua (Lazy spec)
return {
	"seblyng/roslyn.nvim",
	ft = { "cs", "vb" }, -- C#, Visual Basic
	opts = {
		broad_search = true, -- find .sln in parents
		config = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			settings = {
				-- Examples; tweak to taste
				["csharp|completion"] = {
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_parameters = true,
				},
			},
		},
	},
}
