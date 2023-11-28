-- neovim configuration

-- helpers
--
local fn = vim.fn
local map = vim.api.nvim_set_keymap

-- global setting and options
--
vim.cmd [[
if &shell =~# 'fish$'
    set shell=fish
endif
]]

map('n', '<Space>', '', { nowait = true })
vim.g.mapleader = ' ' -- setup leader key

-- use TAB/S-TAB for select items in menu
vim.keymap.set('i', '<C-i>', function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

map('n', '<leader>t', ':vsplit term://fish<cr>', {})
map('t', '<ESC>', '<C-\\><C-n>', {})

-- change keymap
map('n', '<C-Space>', 'i<C-^><ESC>', {})
map('i', '<C-Space>', '<C-^>', {})
map('c', '<C-Space>', '<C-^><ESC>', {})

-- enable spelling
map('n', '<F2>', ':setlocal spell!<cr>', {})

require('disable-builtins')
require('setup-options')

-- packer as plugin manager
--
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').init({ ensure_dependencies = true, auto_clean = true })

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- packer it self
  use 'nvim-lua/plenary.nvim'  -- utility library

  -- load and configure modules
  --
  -- user interface
  use(require('setup-ui'))
  -- searching and selections support
  use(require('setup-ss'))
  -- about file type support
  use(require('setup-ft'))
  -- version control support
  use(require('setup-vcs'))
  -- text highlighting and spelling support
  use(require('setup-text'))
  -- completion and snippet support
  use(require('setup-cmp'))
  -- language server protocol support
  use(require('setup-lsp'))
  -- source debugging support
  use(require('setup-dap'))

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.api.nvim_create_augroup('Others', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'Others',
  pattern = { '*' },
  callback = function()
    vim.cmd 'setlocal nonumber norelativenumber'
    vim.cmd 'setlocal nospell'
    vim.cmd 'setlocal signcolumn=auto'
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Others',
  pattern = { '*' },
  command = '%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'Others',
  pattern = { '*' },
  callback = function()
    vim.highlight.on_yank { timeout = 400, on_visual = false }
  end,
})
