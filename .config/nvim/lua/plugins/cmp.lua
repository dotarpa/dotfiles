return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"onsails/lspkind.nvim",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			local function has_words_before()
				if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				if col == 0 then
					return false
				end
				local text = vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
				return text:match("^%s*$") == nil
			end

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({ border = "single" }),
					documentation = cmp.config.window.bordered({ border = "single" }),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
					["<S-Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "copilot" },
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer", keyword_length = 2 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						symbol_map = { copilot = "" },
					}),
				},
			})
		end,
	},
}
