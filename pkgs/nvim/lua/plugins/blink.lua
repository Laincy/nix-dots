return {
	{
		"luasnip",
		for_cat = "cmp",
		enabled = nixCats("cmp") or false,
		dep_of = { "blink.cmp" },
		after = function(_)
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			local ls = require("luasnip")

			vim.keymap.set({ "i", "s" }, "<M-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end)
		end,
	},
	{
		"blink.cmp",
		for_cat = "cmp",
		enabled = nixCats("cmp") or false,
		event = "DeferredUIEnter",
		after = function(_)
			require("blink.cmp").setup({
				keymap = {
					preset = "default",
				},

				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},

				cmdline = {
					enabled = true,
					completion = {
						menu = {
							auto_show = true,
						},
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						-- Search forward and backward
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						-- Commands
						if type == ":" or type == "@" then
							return { "cmdline" }
						end
						return {}
					end,
				},
				fuzzy = {
					sorts = {
						"exact",
						"score",
						"sort_text",
					},
				},
				signature = {
					enabled = true,
					window = {
						show_documentation = true,
					},
				},
				snippets = {
					preset = "luasnip",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "omni" },
					providers = {
						path = {
							score_offset = 20,
						},
						lsp = {
							score_offset = 50,
						},
						snippets = {
							score_offset = 40,
						},
						buffer = {
							score_offset = -10,
						},
					},
				},
			})
		end,
	},
}
