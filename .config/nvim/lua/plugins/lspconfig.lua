return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lsp")
		end,
	},
}
