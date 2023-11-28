local M = {
  -- color scheme
  {
    "EdenEast/nightfox.nvim",
    tag = "v1.0.0",
    config = function() vim.cmd('colorscheme nordfox') end
  },

  -- tint inactive windows
  {
    'levouh/tint.nvim',
    config = function()
      require("tint").setup({
        tint = -20,                                                 -- Darken colors,  a positive value to brighten
        saturation = 0.2,                                           -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT,      -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = true,                              -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == "terminal" or floating
        end
      })
    end
  },

  -- status line
  {
    'vsratobury/nvim-hardline',
    config = function()
      require('hardline').setup({
        bufferline = true,
        theme = 'nord',
        sections = {
          { class = 'mode', item = require('hardline.parts.mode').get_item },
          { class = 'med',  item = require('hardline.parts.keymap').get_item },
          { class = 'high', item = require('hardline.parts.git').get_item,     hide = 100 },
          { class = 'med',  item = require('hardline.parts.filename').get_item },
          '%<',
          { class = 'med',     item = '%=' },
          { class = 'low',     item = require('hardline.parts.wordcount').get_item, hide = 100 },
          { class = 'error',   item = require('hardline.parts.lsp').get_error },
          { class = 'warning', item = require('hardline.parts.lsp').get_warning },
          { class = 'warning', item = require('hardline.parts.whitespace').get_item },
          { class = 'high',    item = require('hardline.parts.filetype').get_item,  hide = 80 },
          { class = 'mode',    item = require('hardline.parts.line').get_item },
        },
      })
    end
  },

  -- wich key for keymapping
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 30,
          }
        }
      })
    end
  },

  {
    'ggandor/lightspeed.nvim',
    -- config = function()
    --   require('lightspeed').setup()
    -- end
  },

  -- show ident lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.g['indent_blankline_char'] = '┊'
      vim.g['indent_blankline_buftype_exclude'] = { 'terminal' }
      vim.g['indent_blankline_filetype_exclude'] = { 'fugitive', 'fzf', 'help', 'man' }
    end
  }
}

return M
