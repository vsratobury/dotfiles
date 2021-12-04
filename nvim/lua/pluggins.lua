-- plugins.lua
--

-------------------- HELPERS -------------------------------
local api, fn, g = vim.api, vim.fn, vim.g
local fmt = string.format

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-------------------- PLUGINS -------------------------------

return require('packer').startup(function(use)
   use 'monsonjeremy/onedark.nvim' 
   use 'rakr/vim-one' 
   use 'junegunn/fzf' 
   use 'junegunn/fzf.vim' 
   use 'neovim/nvim-lspconfig' 
   use 'ojroques/nvim-lspfuzzy' 
   use 'nvim-lua/plenary.nvim' 
   use 'nvim-treesitter/nvim-treesitter'
   use 'nvim-treesitter/nvim-treesitter-textobjects'
   use 'smiteshp/nvim-gps' 
   use 'lewis6991/gitsigns.nvim' 
   use 'lukas-reineke/indent-blankline.nvim' 

   use 'hrsh7th/cmp-nvim-lsp' 
   use 'hrsh7th/cmp-buffer' 
   use 'hrsh7th/cmp-path' 
   use 'hrsh7th/cmp-cmdline' 
   use 'hrsh7th/nvim-cmp' 
   use 'hrsh7th/cmp-vsnip' 
   use 'hrsh7th/vim-vsnip' 
   use 'rafamadriz/friendly-snippets' 

   use 'terrortylor/nvim-comment' 
   use 'folke/which-key.nvim' 
   use 'kristijanhusak/orgmode.nvim' 
   use 'vsratobury/vim-cmake' 
   use 'vsratobury/nvim-hardline' 
   use 'tpope/vim-fugitive' 
   use 'sebdah/vim-delve' 

   use 'jiangmiao/auto-pairs' 
if packer_bootstrap then
	require('packer').sync()
end
end)

