return {
	"rust_analyzer",
	lsp = {
		enabled = nixCats("rust") or false,
		filetypes = { "rust" },

		settings = {
			["rust-analyzer"] = {
				-- imports = {
				-- 	granularity = {
				-- 		group = "module",
				-- 	},
				-- 	prefix = "self",
				-- },
				-- cargo = {
				--
				-- 	allTargets = false,
				-- 	buildScripts = {
				-- 		enable = true,
				-- 	},
				-- },
				-- procMacro = {
				-- 	enable = true,
				-- },
			},
		},
	},
}
