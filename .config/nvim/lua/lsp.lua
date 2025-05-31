local cmp = require('cmp')
local lspkind = require('lspkind')
local lspconfig = require('lspconfig')

-- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#tab-completion-configuration-highly-recommended
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local text = vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
  return text:match("^%s*$") == nil
end

cmp.setup({
	window = {
		completion = cmp.config.window.bordered({ border = 'single' }),
		documentation = cmp.config.window.bordered({ border = 'single' }),
	},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		['<S-Tab>'] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else 
				fallback()
			end
		end),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'copilot' },
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer', keyword_length = 2 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			maxwidth = 50,
			ellipsis_char = '...',
			symbol_map = { copilot = '' },
            -- symbol_map = { copilot = '★' },
		})
	}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig.pyright.setup { 
    capabilities = capabilities,
    filetypes = {'py'},
}
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

local ts_opts = {}
ts_opts.on_attach = function(client)
	if not is_node_dir() then
		client.stop(true)
	end
end
lspconfig.ts_ls.setup(ts_opts)

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
        	vim.keymap.set('n', 'ge', vim.diagnostic.open_float, opts)
        	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    end,
})

-- カスタム関数を作成

local function copy_diagnostics_to_clipboard()
    -- カーソル位置の診断メッセージを取得
    local diagnostics = vim.diagnostic.get()
    local line_diagnostics = {}

    -- 診断メッセージをフォーマット
    for _, diagnostic in ipairs(diagnostics) do
        table.insert(line_diagnostics, diagnostic.message)
    end

    -- テーブルを文字列に結合
    local diagnostics_text = table.concat(line_diagnostics, '\n')

    -- クリップボードにコピー
    vim.fn.setreg('+', diagnostics_text)

    -- print("Diagnostics copied to clipboard!")
end

-- キーマップに設定
vim.keymap.set('n', '<leader>y', copy_diagnostics_to_clipboard, { noremap = true, silent = true })
