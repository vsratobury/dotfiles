-- plugins.lua
--
-------------------- HELPERS -------------------------------
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

-------------------- PLUGINS -------------------------------

require('packer').init({ ensure_dependencies = true, auto_clean = true })

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'ericvw/vim-fish'
  use 'tpope/vim-fugitive'
  use 'sebdah/vim-delve'
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0", config = function() vim.cmd('colorscheme nordfox') end }
  use { 'terrortylor/nvim-comment', config = function() require('nvim_comment').setup() end }
  use { 'jiangmiao/auto-pairs' }
  use { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
        topdelete = { text = '-' },
        changedelete = { text = '≃' }
      }
    }
  end }
  use {
    'LionC/nest.nvim',
    config = function()
      local keymap = require('configure.keymaps')
      require('nest').applyKeymaps(keymap.default)
    end
  }
  use { 'folke/which-key.nvim', config = function()
    require('which-key').setup({
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 30,
        }
      }
    })
  end }
  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    vim.g['indent_blankline_char'] = '┊'
    vim.g['indent_blankline_buftype_exclude'] = { 'terminal' }
    vim.g['indent_blankline_filetype_exclude'] = { 'fugitive', 'fzf', 'help', 'man' }
  end }
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use { 'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }
  use { 'Civitasv/cmake-tools.nvim', config = function()
    require("cmake-tools").setup {
      cmake_command = "cmake",
      cmake_build_directory = "build",
      cmake_build_type = "Debug",
      cmake_generate_options = { "-G", "Ninja" },
      cmake_build_options = {},
      cmake_console_size = 10, -- cmake output window height
      cmake_show_console = "only_on_error", -- "always", "only_on_error"
      -- cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
      -- cmake_dap_open_command = require("dap").repl.open, -- optional
    }
  end }
  use { 'mfussenegger/nvim-dap' }
  use {
    'lervag/vimtex',
    config = function()
      vim.g['vimtex_view_method'] = 'skim'
      vim.g['tex_conceal'] = 'abdmg'
    end
  }
  use {
    'lewis6991/spellsitter.nvim',
    requires = {
    },
    config = function()
      require('spellsitter').setup()
      vim.api.nvim_create_augroup('Spell', { clear = true })
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*", -- disable spellchecking in the embeded terminal
        command = "setlocal nospell",
        group = 'Spell',
      })
    end
  }

  use(require('configure.statusline'))
  use(require('configure.completions'))
  use(require('configure.lsp'))
  use(require('configure.treesitter'))
  -- use (require('configure.orgmode'))
  use(require('configure.telescope'))

  if packer_bootstrap then
    require('packer').sync()
  end
end)
