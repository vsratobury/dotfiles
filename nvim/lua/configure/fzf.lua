return {
    'junegunn/fzf.vim',
    requires = {
        'junegunn/fzf',
        'ojroques/nvim-lspfuzzy'
    },
    config = function()
        vim.g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
        require('lspfuzzy').setup()
    end,
}
