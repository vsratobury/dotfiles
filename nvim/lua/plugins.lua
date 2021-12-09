-- plugins.lua
--

-------------------- HELPERS -------------------------------
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-------------------- PLUGINS -------------------------------

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'vsratobury/vim-cmake'
    use 'tpope/vim-fugitive'
    use 'sebdah/vim-delve'

    use (require('configure.ui-nord'))
    use (require('configure.statusline'))
    -- use (require('configure.fzf'))
    use (require('configure.completions'))
    use (require('configure.lsp'))
    use (require('configure.treesitter'))
    -- use (require('configure.orgmode'))
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'nvim-telescope/telescope-cheat.nvim'}
    use {'tami5/sqlite.lua'}
    use (require('configure.telescope'))
    use (require('configure.autopairs'))
    use (require('configure.nest'))

    if packer_bootstrap then
        require('packer').sync()
    end
end)

