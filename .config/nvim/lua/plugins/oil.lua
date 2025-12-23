return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
			},
		},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Oil open parent dir" },
		},
	},
}
