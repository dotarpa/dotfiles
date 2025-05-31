return {
	'nvimtools/none-ls.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettierd.with({
					prefer_local = "node_modules/.bin",
					disabled_filetypes = { "markdown" },
				}),
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.stylua,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ 
								sync = false,
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end
}

--return {
--    'nvimtools/none-ls.nvim',
--    config = function()
--        local nls = require('none-ls')
--        nls.setup({
--            sources = {
--                nls.builtins.formatting.prettier,
--                nls.builtins.diagnostics.eslint,
--                nls.builtins.code_actions.eslint,
--                nls.builtins.formatting.stylua,
--                nls.builtins.formatting.rustfmt,
--            },
--            on_attach = function(client, bufnr)
--                if client.supports_method('textDocument/formatting') then
--                    vim.api.nvim_create_autocmd('BufWritePre', {
--                        buffer = bufnr,
--                        callback = function()
--                            vim.lsp.buf.format({ async = true })
--                        end,
--                    })
--                end
--            end,
--        })
--    end,
--}
