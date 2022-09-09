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
  use 'wbthomason/packer.nvim' -- packer it self
  use 'nvim-lua/plenary.nvim' -- utility library
  use 'ericvw/vim-fish' -- fish file type support
  use 'tpope/vim-fugitive' -- git support
  use 'sebdah/vim-delve' -- go debug support
  -- color scheme
  use { "EdenEast/nightfox.nvim", tag = "v1.0.0", config = function() vim.cmd('colorscheme nordfox') end }
  -- tint inactive windows
  use { 'levouh/tint.nvim', config = function()
    require("tint").setup({
      tint = -20, -- Darken colors, use a positive value to brighten
      saturation = 0.2, -- Saturation to preserve
      transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = true, -- Tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == "terminal" or floating
      end
    })
  end }
  -- smart commenting
  use { 'terrortylor/nvim-comment', config = function() require('nvim_comment').setup() end }
  -- support auto pairs for ([{" (nvim version > 0.7 bug)
  -- use { 'jiangmiao/auto-pairs', config = function()
  --   vim.api.nvim_create_augroup('AutoPairs', { clear = true })
  --   vim.api.nvim_create_autocmd("BufEnter", {
  --     group = 'AutoPairs',
  --     pattern = { 'Telescope*' }, -- disable AutoPairs in the Telescope
  --     command = 'let b:AutoPairs = ""',
  --   })
  -- end }
  -- interactive signs for git live diff
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
  -- smart keymapping
  use {
    'LionC/nest.nvim',
    config = function()
      local keymap = require('configure.keymaps')
      require('nest').applyKeymaps(keymap.default)
    end
  }
  -- wich key for keymapping
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
  -- show ident lines
  use { 'lukas-reineke/indent-blankline.nvim', config = function()
    vim.g['indent_blankline_char'] = '┊'
    vim.g['indent_blankline_buftype_exclude'] = { 'terminal' }
    vim.g['indent_blankline_filetype_exclude'] = { 'fugitive', 'fzf', 'help', 'man' }
  end }
  -- smart quick fix window
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
  use { 'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }
  -- cmake interctive support
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
  -- c++/c/rust debugging
  use { 'mfussenegger/nvim-dap' }
  -- Tex/LaTex file type support and compiling
  use {
    'lervag/vimtex',
    config = function()
      vim.g['vimtex_view_method'] = 'skim'
      vim.g['tex_conceal'] = 'abdmg'
    end
  }

  use(require('configure.statusline'))
  use(require('configure.completions'))
  use(require('configure.lsp'))
  -- use (require('configure.orgmode'))
  use(require('configure.telescope'))
  -- language tanslate
  use(require('configure.translate'))
  -- treesitter pluggins configure
  use(require('configure.treesitter'))
  -- treesitter support for spelling (on nvim version >= 0.8 depricated)
  use {
    'lewis6991/spellsitter.nvim',
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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
