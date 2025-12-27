return {
	{
		"shellRaining/hlchunk.nvim",
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
