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
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            -- { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    {
        'zbirenbaum/copilot.lua',
	event = "InsertEnter",
        config = function()
        	require("copilot").setup({
                	suggestion = {enabled = false},
                    	panel = {enabled = false},
                })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
	after = { "copilot.lua" },
        config = function ()
            require("copilot_cmp").setup()
        end,
    },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}

