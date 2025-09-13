local lze = require("lze")

lze.load({
	{
		"neo-tree.nvim",
		for_cats = "general",
		keys = {
			{ "<C-n>", ":Neotree toggle left<CR>", mode = { "n" }, desc = "Neotree toggle" },
		},

		after = function(_)
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					filtered_items = { hide_dotfiles = true, never_show = { ".git" } },
				},

				window = { width = 30 },
			})
		end,
	},
	{
		"lualine.nvim",
		for_cat = "general.extra",
		event = "DeferredUIEnter",

		after = function()
			require("lualine").setup({
				options = {
					theme = "moonfly",
					globalstatus = true,
				},

				sections = {
					lualine_x = { "fileformat", "lsp_status", "filetype" },
				},
			})
		end,
	},
	{
		"markview.nvim",
		for_cats = "markdown",
		event = "DeferredUIEnter",

		enabled = nixCats("markdown") or false,

		after = function()
			local presets = require("markview.presets")

			require("markview").setup({
				markdown = {
					headings = presets.headings.marker,
					tables = presets.tables.single,
				},
			})
		end,
	},

	{
		"indent-blankline.nvim",
		for_cats = "general.core",
		event = "DeferredUIEnter",

		after = function()
			require("ibl").setup({

				indent = {
					char = "│",
				},
				scope = {
					exclude = {
						language = { "nix" },
					},
				},
			})
		end,
	},

	{
		"presence.nvim",
		for_cats = "gen$ral.extra",
		event = "DeferredUIEnter",
		after = function()
			require("presence").setup()
		end,
	},

	{ import = "plugins.blink" },
	{ import = "plugins.codestyle" },
})
