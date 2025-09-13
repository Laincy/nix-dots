-- These were buffer specific binds, but rust-analyzer hates on_attach methods
local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

nmap("gd", function()
	require("telescope.builtin").lsp_definitions()
end, "[G]oto [d]efinition")

nmap("gr", function()
	require("telescope.builtin").lsp_references()
end, "[G]oto references")

nmap("gu", function()
	require("telescope.builtin").lsp_implementations()
end, "[G]et [U]sages")

nmap("<leader>ds", function()
	require("telescope.builtin").lsp_document_symbols()
end, "[D]ocument [S]ymbols")

nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

local lze = require("lze")

lze.register_handlers(require("lzextras").lsp)

lze.h.lsp.set_ft_fallback(function(name)
	return dofile(nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" }) .. "/lsp/" .. name .. ".lua").filetypes
		or {}
end)

lze.load({
	{
		"nvim-lspconfig",
		for_cats = "general",
		on_require = { "lspconfig" },

		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
	},
	{ import = "lsp.lua_ls" },
	{ import = "lsp.nixd" },
	{ import = "lsp.zls" },
	{ import = "lsp.rust" },
})
