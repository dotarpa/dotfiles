return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},

		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					preview = { treesitter = false },
					layout_strategy = "vertical",
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
						n = {
							["q"] = actions.close,
							["<esc>"] = actions.close,
						},
					},
				},
				extensions = {
					["ui-select"] = require("telescope.themes").get_dropdown({}),
					file_browser = { hijack_netrw = true },
				},
			})

			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "file_browser")
			pcall(telescope.load_extension, "ui-select")

			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Telescope: find files" })

			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: help" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope: diagnostics" })

			vim.keymap.set("n", "<leader>fe", function()
				telescope.extensions.file_browser.file_browser({
					path = vim.fn.expand("%:p:h"),
					select_buffer = true,
				})
			end, { desc = "Telescope: file browser (cwd of file)" })
		end,
	},
}
