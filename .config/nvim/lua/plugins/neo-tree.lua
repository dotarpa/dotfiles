return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
	    "nvim-lua/plenary.nvim",
	    "nvim-tree/nvim-web-devicons",
	    "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
	    -- fill any relevant options here
    },
    config = function()
	require("neo-tree").setup({
	    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	    enable_git_status = true, -- Enable git status in the file explorer
    	})
    	-- vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>')
    	vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
    end,
}
