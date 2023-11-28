vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Gitsigns attach<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gh', ':Gitsigns detach<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gl', ':Gitsigns toggle_current_line_blame<cr>', {})

local M = {
  -- git support
  { 'tpope/vim-fugitive' },

  -- interactive signs for git live diff
  {
    'lewis6991/gitsigns.nvim',
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
    end
  }
}

return M
