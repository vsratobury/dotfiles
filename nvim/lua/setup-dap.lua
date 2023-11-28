function Debug_program()
  require("dap.ext.vscode").load_launchjs("launch.json", { codelldb = { "cpp", "c" } })
  -- require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "cpp", "c" } })
  require("dap").continue()
end

function Stop_debug_program()
  require("dap").terminate()
  vim.cmd(":only")
  -- vim.cmd(":%bd! | e#")
end

function Dap_open_scopes()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end

function Dap_open_frames()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end

local map = vim.api.nvim_set_keymap
-- dap debug functions
map('n', '<leader>dd', ':lua Debug_program()<cr>', {})
map('n', '<leader>dD', ':lua require("dap").run_last()<cr>', {})
map('n', '<leader>dq', ':lua Stop_debug_program()<cr>', {})
map('n', '<leader>dS', ':lua Dap_open_scopes()<cr>', {})
map('n', '<leader>dF', ':lua Dap_open_frames()<cr>', {})
map('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<cr>', {})
map('n', '<leader>dB', ':lua require("dap").list_breakpoints()<cr>:copen<cr>', {})
map('n', '<leader>dC', ':lua require("dap").clear_breakpoints()<cr>', {})
map('n', '<leader>dW', ':lua require("dap").repl.toggle()<cr>', {})
map('n', '<leader>dc', ':lua require("dap").continue()<cr>', {})
map('n', '<leader>dr', ':lua require("dap").run_to_cursor()<cr>', {})
map('n', '<leader>dn', ':lua require("dap").step_over()<cr>', {})
map('n', '<leader>di', ':lua require("dap").step_into()<cr>', {})
map('n', '<leader>do', ':lua require("dap").step_out()<cr>', {})

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
