-- configure UI
return {
    'lervag/vimtex',
    requires = {
    },
    config = function()
        vim.g['vimtex_view_method'] = 'skim'
    end
}
