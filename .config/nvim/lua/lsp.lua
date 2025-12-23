local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- capabilities: cmp_nvim_lsp があるなら拡張
local capabilities = vim.lsp.protocol.make_client_capabilities()
do
	local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_lsp.default_capabilities(capabilities)
	end
end

-- snippets が不要なら off（必要ならこの行は削除）
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- LSP servers
lspconfig.pyright.setup({
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {},
	},
})

-- TypeScript (ts_ls または tsserver)
local ts = lspconfig.ts_ls or lspconfig.tsserver

local function is_node_project(bufnr)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	if fname == "" then
		return false
	end
	local root = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
	return root ~= nil
end

if ts then
	ts.setup({
		capabilities = capabilities,
		root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
		single_file_support = false,
		on_attach = function(client, bufnr)
			if not is_node_project(bufnr) then
				client.stop()
			end
		end,
	})
end

-- LspAttach: buffer local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		-- ここが重要: vim.diagnostic（diagnostics ではない）
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
	end,
})

-- カーソル行の診断メッセージをクリップボードにコピー
local function copy_diagnostics_to_clipboard()
	local bufnr = 0
	local lnum = vim.fn.line(".") - 1 -- diagnostic は 0-index
	local diags = vim.diagnostic.get(bufnr, { lnum = lnum })

	if #diags == 0 then
		vim.fn.setreg("+", "")
		return
	end

	local lines = {}
	for _, diag in ipairs(diags) do
		local src = diag.source and ("[" .. diag.source .. "] ") or ""
		table.insert(lines, src .. diag.message)
	end

	vim.fn.setreg("+", table.concat(lines, "\n"))
end

vim.keymap.set("n", "<leader>y", copy_diagnostics_to_clipboard, { noremap = true, silent = true })
