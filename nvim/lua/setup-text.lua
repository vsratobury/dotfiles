local M = {
  -- smart commenting
  { 'terrortylor/nvim-comment',
    config = function() require('nvim_comment').setup() end },

  -- treesitter support for spelling (on nvim version >= 0.8 depricated)
  { 'lewis6991/spellsitter.nvim',
    config = function()
      require('spellsitter').setup()
      vim.api.nvim_create_augroup('Spell', { clear = true })
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*", -- disable spellchecking in the embeded terminal
        command = "setlocal nospell",
        group = 'Spell',
      })
    end },

  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = '0.5-compat' },

  { 'nvim-treesitter/nvim-treesitter', branch = 'master', run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'go', 'cpp', 'c', 'lua', 'python', 'fish', 'vim', 'ninja', 'cmake', 'bash', 'fortran',
          'latex',
          'comment' },
        highlight = {
          enable = true, -- disable = {'go', 'c', 'cpp'},
          additional_vim_regex_highlighting = { 'org' }
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer', ['if'] = '@function.inner',
              ['ac'] = '@class.outer', ['ic'] = '@class.inner',
              ['ab'] = '@block.outer', ['ib'] = '@block.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = { ['<leader>a'] = '@parameter.inner' },
            swap_previous = { ['<leader>A'] = '@parameter.inner' },
          },
          move = {
            enable = true,
            goto_next_start = {
              [']a'] = '@parameter.outer',
              [']f'] = '@function.outer',
              [']]'] = '@class.outer',
              [']*'] = '@comment.outer',
            },
            goto_next_end = {
              [']A'] = '@parameter.outer',
              [']F'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[a'] = '@parameter.outer',
              ['[f'] = '@function.outer',
              ['[['] = '@class.outer',
              ['[*'] = '@comment.outer',
            },
            goto_previous_end = {
              ['[A'] = '@parameter.outer',
              ['[F'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
        },
      }
    end }
}

return M
