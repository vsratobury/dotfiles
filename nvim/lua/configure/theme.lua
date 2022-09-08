-- configure UI
return {
    'shaunsingh/nord.nvim',
    requires = {
        {
          'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g['indent_blankline_char'] = '┊'
            vim.g['indent_blankline_buftype_exclude'] = {'terminal'}
            vim.g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}
        end},
        {'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = {text = '+'},
                    change = {text = '~'},
                    delete = {text = '-'},
                    topdelete = {text = '-'},
                    changedelete = {text = '≃'},
                },
            }
        end},
        {'folke/which-key.nvim',
        config = function()
            require('which-key').setup( {
                plugins = {
                    spelling = {
                        enabled = true,
                        suggestions = 30,
                    }
                }
            })
        end},
        {'terrortylor/nvim-comment', config = require('nvim_comment').setup()},
        {'levouh/tint.nvim', config = require('tint.nvim').setup()},
    },
    config = function()
        vim.g.nord_borders = true
        vim.g.nord_contrast = true
        require('nord').set()
    end
}
