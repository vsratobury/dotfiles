-- neovim config -- version 5
--

-- fish shell options
vim.cmd [[
if &shell =~# 'fish$'
    set shell=fish
endif
]]

-- map leader key
vim.api.nvim_set_keymap('n', '<Space>', '', {nowait = true})
vim.g.mapleader = ' '

require('disable-builtins')
require('plugins')
require('options')
require('keymaps')
require('autocommands')

