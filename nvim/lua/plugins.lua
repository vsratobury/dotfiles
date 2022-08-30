-- plugins.lua
--
-------------------- HELPERS -------------------------------
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

-------------------- PLUGINS -------------------------------

require('packer').init({ensure_dependencies = true, auto_clean = true})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'vsratobury/vim-cmake'
    use 'ericvw/vim-fish'
    use 'tpope/vim-fugitive'
    use 'sebdah/vim-delve'

    use (require('configure.ui'))
    use (require('configure.theme'))
    use (require('configure.statusline'))
    -- use (require('configure.fzf'))
    use (require('configure.completions'))
    use (require('configure.lsp'))
    use (require('configure.treesitter'))
    -- use (require('configure.orgmode'))
    use (require('configure.telescope'))
    use (require('configure.autopairs'))
    use (require('configure.nest'))
    use (require('configure.vimtex'))


    if packer_bootstrap then
        require('packer').sync()
    end
end)

