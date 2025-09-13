return {
	"zls",
	lsp = {
		enabled = nixCats("zig") or false,
		fileTypes = { "zig" },

		settings = {
			zls = {},
		},
	},
}
