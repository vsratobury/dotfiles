-- neovim config -- version 5
--

-- map leader key
vim.api.nvim_set_keymap('n', '<Space>', '', {nowait = true})
vim.g.mapleader = ' '

require('disable-builtins')
require('plugins')
require('options')
-- require('mappings')
require('autocommands')

