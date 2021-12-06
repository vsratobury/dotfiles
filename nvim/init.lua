-- neovim config -- version 4
--

local api, fn, g = vim.api, vim.fn, vim.g
local fmt = string.format

------------------- RUN PARTS -------------------------------

require('plugins')
require('options')
require('mappings')
require('autocommands')

