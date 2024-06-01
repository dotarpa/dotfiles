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
    'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {},
}

