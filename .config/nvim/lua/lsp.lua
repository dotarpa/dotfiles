local cmp = require('cmp')
local lspkind = require('lspkind')
local lspconfig = require('lspconfig')

cmp.setup({
	window = {
		completion = cmp.config.window.bordered({ border = 'single' }),
		documentation = cmp.config.window.bordered({ border = 'single' }),
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer', keyword_length = 2 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			maxwidth = 50,
			ellipsis_char = '...',
		})
	}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.gopls.setup {
	capabilities = capabilities,
	filetypes = {'go'},
}
lspconfig.rust_analyzer.setup {
	capabilities = capabilities,
	settings = {
		['rust-analyzer'] = {},
	},
	filetypes = {'rs'},
}

vim.api.nvim_create_autocmd('LspAttach',{
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:h vim.lsp.*`
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    end,
})
