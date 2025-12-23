return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",

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
					border = true,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt_prefix = "  ",
					selection_caret = "> ",
					entry_prefix = "  ",

					sorting_strategy = "descending",
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.90,
						height = 0.85,
						preview_width = 0.55,
						prompt_position = "bottom",
					},

					path_display = { "smart" },

					-- ft_to_lang 問題回避
					preview = { treesitter = false },

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

			-- キーマップ
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
