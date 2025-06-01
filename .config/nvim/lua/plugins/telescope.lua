return {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        config = function()
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = { ["<ecs>"] = actions.close },
                        n = { ["q"] = actions.close },
                    },
                    layout_strategy = 'vertical'
                }
            }
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        end
}
