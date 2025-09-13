vim.cmd.colorscheme("moonfly")

vim.diagnostic.config({ virtual_text = true })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.inccommand = "split"

vim.opt.wrap = false

vim.opt.fillchars = { eob = " " }

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.expandtab = true

vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.g.markdown_recommended_style = 0

require("plugins")
require("lsp")
