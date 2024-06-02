return {
    'folke/lazy.nvim',
    'Townk/vim-autoclose',
    'cocopon/iceberg.vim',
    { 'fatih/vim-go',
        ft = "go",
        init = function()
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_dec_keywordprg_enabled = 0
        end,
    },
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    'onsails/lspkind.nvim',
    {
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
    },
    {
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
    },
--    {
--        "shellRaining/hlchunk.nvim",
--        event = { "BufReadPre", "BufNewFile" },
--        config = function()
--            require("hlchunk").setup({
--                chunk = {
--                    enable = true,
--                    use_treesitter = true,
--                    priority = 15,
--                    chars = {
--                        horizontal_line = "-",
--                        vertical_line = "|",
--                        -- left_top = "╭",
--                        left_top = "┌",
--                        -- left_bottom = "╰",
--                        left_bottom = "└",
--                        right_arrow = ">",
--                        -- right_arrow = "-",
--                    },
--                },
--            })
--        end
--    },
}

