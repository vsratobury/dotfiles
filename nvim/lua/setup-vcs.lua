local M = {
  -- git support
   { 'tpope/vim-fugitive' },

  -- interactive signs for git live diff
   { 'lewis6991/gitsigns.nvim',
    config = function()
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
}

return M
