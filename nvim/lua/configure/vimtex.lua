-- configure TEX
return {
    'lervag/vimtex',
    requires = {
    },
    config = function()
        vim.g['vimtex_view_method'] = 'skim'
        vim.g['tex_conceal'] = 'abdmg'
    end
}
