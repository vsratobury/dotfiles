-- configure UI
return {
    'shaunsingh/nord.nvim',
    requires = {
        'lukas-reineke/indent-blankline.nvim',
        'lewis6991/gitsigns.nvim',
        'folke/which-key.nvim',
        'terrortylor/nvim-comment',
    },
    config = function()
        -- indent-blankline.nvim
        vim.g['indent_blankline_char'] = '┊'
        vim.g['indent_blankline_buftype_exclude'] = {'terminal'}
        vim.g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}

        vim.g.nord_borders = true
        vim.g.nord_contrast = true
        require('nord').set()

        require('gitsigns').setup {
            signs = {
                add = {text = '+'},
                change = {text = '~'},
                delete = {text = '-'},
                topdelete = {text = '-'},
                changedelete = {text = '≃'},
            },
        }
        require('nvim_comment').setup()
        require('which-key').setup( {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 30,
                }
            }
        })
    end
}
