vim.scriptencoding = "utf-8"

vim.o.encoding = "utf-8"
vim.o.ambiwidth = "double"
vim.o.termguicolors = true
vim.opt.clipboard:append { "unnamedplus" }

vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.smartindent = true
-- vim.bo.nrformats:remove {"octal"}

vim.wo.cursorline = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true

vim.cmd[[highlight Search cterm=bold,reverse guibg=bold,reverse]]
vim.cmd[[colorscheme iceberg]]
vim.cmd[[syntax enable]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.python3_host_prog = '$HOME/.venv/bin/python3'

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':noh<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<C-j>', ':bprev<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<C-k>', ':bnext<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap=true, silent=true })

require("lazy_nvim")
require("lsp")

