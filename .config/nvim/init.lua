vim.scriptencoding = "utf-8"

vim.o.encoding = "utf-8"
-- vim.o.ambiwidth = "double"
vim.o.ambiwidth = "single"
vim.o.termguicolors = true
vim.opt.clipboard:append({ "unnamedplus" })

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
-- vim.bo.nrformats:remove {"octal"}

vim.wo.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true

vim.cmd([[highlight Search cterm=bold,reverse guibg=bold,reverse]])
vim.cmd([[colorscheme iceberg]])
vim.cmd([[syntax enable]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "$HOME/.venv-nvim/bin/python3"

vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })

vim.opt.completeopt = { "menuone", "noselect", "popup" }
-- vim.opt.completeopt:append({ "menuone", "noselect", "popup" })

require("lazy_nvim")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "tsx", "jsx" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

vim.g.have_nerd_font = true
vim.opt.splitright = true

-- require("copilotchat")
