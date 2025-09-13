return {
	"telescope.nvim",
	for_cat = "general.extra",

	cmd = { "Telescope" },
	on_require = "telescope",

	keys = {
		{
			"<C-f>",
			":Telescope current_buffer_fuzzy_find<CR>",
			mode = { "n" },
			desc = "Find in buffer",
		},
		{
			"<leader>ff",
			":Telescope find_files<CR>",
			mode = { "n" },
			desc = "Find files",
		},
		{
			"<leader>fg",
			":Telescope live_grep<CR>",
			mode = { "n" },
			desc = "Find grep",
		},
		{
			"<leader>fk",
			":Telescope keymaps<CR>",
			mode = { "n" },
			desc = "Find keybinds",
		},
	},

	after = function(_)
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"%.lock",
				},
			},

			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})
	end,
}
