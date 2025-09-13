-- Formatting and linting
return {
	{
		"conform.nvim",
		for_cat = "general.style",
		keys = { "<leader>fmt", desc = "Format file" },

		after = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					nix = { "alejandra" },
					markdown = { "markdownlint" },
					zig = nixCats("zig") and { "zigfmt" } or nil,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file" })
		end,
	},
	{
		"nvim-lint",
		for_cat = "general.style",

		event = "FileType",
		after = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				gitcommit = { "commitlint" },
				nix = { "nix" },

				rust = nixCats("rust") and { "clippy" } or nil,
			}

			lint.linters.markdownlint.args = { "--stdin", "--disable", "MD013", "MD041" }

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
