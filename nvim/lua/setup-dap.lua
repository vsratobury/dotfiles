function Run_dap()
  require("dap.ext.vscode").load_launchjs("launch.json", { codelldb = { "cpp", "c" } })
  -- require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "cpp", "c" } })
  require("dap").continue()
end

local map = vim.api.nvim_set_keymap
-- dap debug functions
map('n', '<leader>ds', ':lua Run_dap()<cr>', {})
map('n', '<leader>dw', ':lua require("dap").repl.toggle()<cr>', {})
map('n', '<leader>dq', ':lua require("dap").terminate()<cr>:%bd!|e#<cr>', {})
map('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<cr>', {})
map('n', '<leader>dl', ':lua require("dap").list_breakpoints()<cr>:copen<cr>', {})
map('n', '<leader>dc', ':lua require("dap").clear_breakpoints()<cr>', {})
map('n', '<leader>dr', ':lua require("dap").run_to_cursor()<cr>', {})
map('n', '<F4>', ':lua require("dap").step_over()<cr>', {})
map('n', '<F5>', ':lua require("dap").step_into()<cr>', {})
map('n', '<F6>', ':lua require("dap").step_out()<cr>', {})
map('n', '<F7>', ':lua require("dap.ui.widgets").hower()<cr>', {})
map('n', '<F8>', ':lua widgets.centered_float(").scopes())<cr>', {})
map('n', '<F9>', ':lua local widgets = require("dap.ui.widgets"); widgets.centered_float(widgets.frames)<cr>', {})
map('n', '<F10>', ':lua local widgets = require("dap.ui.widgets); widgets.centered_float(widgets.preview)<cr>', {})

-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
-- vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
-- vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
-- vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
-- vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
-- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
-- vim.keymap.set('n', '<Leader>lp',
--   function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
--   require('dap.ui.widgets').hover()
-- end)
-- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
--   require('dap.ui.widgets').preview()
-- end)
-- vim.keymap.set('n', '<Leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)

local M = {
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap').adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = '/Users/vsratobury/.tools/codelldb/extension/adapter/codelldb',
          args = { "--port", "${port}" },
        }
      }
      -- require('dap').configurations.cpp = {
      --   {
      --     name = "Launch file",
      --     type = "codelldb",
      --     request = "launch",
      --     program = function()
      --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/Debug/src/', 'file')
      --     end,
      --     cwd = '${workspaceFolder}',
      --     stopOnEntry = false,
      --   },
      -- }
      -- require('dap').configurations.c = require('dap').configurations.cpp
      -- require('dap.ext.vscode').json_decode = vim.fn.json_decode
    end
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup {
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        all_frames = true,
        only_first_definition = false,
        all_references = true,
        virt_text_win_col = 60,
      }
    end
  }
}

return M
