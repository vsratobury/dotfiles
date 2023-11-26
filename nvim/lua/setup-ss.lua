local map = vim.api.nvim_set_keymap

map('n', '<leader>p', ':lua require("telescope").extensions.project.project{ display_type = "full" }<cr>', {})
map('n', '<leader>o', ':Telescope oldfiles<cr>', {})
map('n', '<leader>f', ':Telescope find_files<cr>', {})
map('n', '<leader>j', ':Telescope buffers<cr>', {})
map('n', '<leader>J', ':Telescope jumplist<cr>', {})
map('n', '<leader>g', ':Telescope live_grep<cr>', {})
map('n', '<leader>b', ':Telescope current_buffer_fuzzy_find<cr>', {})
map('n', '<leader>lr', ':Telescope lsp_references<cr>', {})
map('n', '<leader>ls', ':Telescope lsp_document_symbols<cr>', {})

local M = {
  { 'nvim-telescope/telescope-project.nvim' },

  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.4',
    requires = {
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
      require('telescope').setup {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          project = {
            base_dirs = { vim.env.PRJ }
          }
        }
      }
      require('telescope').load_extension('project')
      require('telescope').load_extension('fzf')
    end
  }
}

return M
