-- configure UI
return {
    'lukas-reineke/indent-blankline.nvim',
    requires = {
        'lewis6991/gitsigns.nvim',
        'folke/which-key.nvim',
        'terrortylor/nvim-comment'
    },
    config = function()
        vim.g['indent_blankline_char'] = '┊'
        vim.g['indent_blankline_buftype_exclude'] = {'terminal'}
        vim.g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}
        require('gitsigns').setup {
            signs = {
                add = {text = '+'},
                change = {text = '~'},
                delete = {text = '-'},
                topdelete = {text = '-'},
                changedelete = {text = '≃'},
            }
        }
        require('which-key').setup( {
            plugins = {
                spelling = {
                    enabled = true,
                    suggestions = 30,
                }
            }
        })
        require('nvim_comment').setup()
    end
}
