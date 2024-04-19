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
    'hrsh7th/cmp-buffer', -- buffer source
    -- 'hrsh7th/cmp-path',
    -- 'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'onsails/lspkind.nvim',
}

