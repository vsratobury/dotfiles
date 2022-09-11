function Run_dap()
  require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "cpp", "c" } })
  require("dap").continue()
end

local map = vim.api.nvim_set_keymap
-- dap debug functions
map('n', '<leader>ds', ':lua Run_dap()<cr>', {})
map('n', '<leader>dw', ':lua require("dap").repl.toggle()<cr>', {})
map('n', '<leader>dq', ':lua require("dap").terminate()<cr>:%db|e#<cr>', {})
map('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<cr>', {})
map('n', '<leader>dl', ':lua require("dap").list_breakpoints()<cr>:copen<cr>', {})
map('n', '<leader>dc', ':lua require("dap").clear_breakpoints()<cr>', {})
map('n', '<leader>dr', ':lua require("dap").run_to_cursor()<cr>', {})

local M = {
   { 'mfussenegger/nvim-dap', config = function()
    require('dap').adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        -- CHANGE THIS to your path!
        command = '/rs/vsratobury/.tools/codelldb/extension/adapter/codelldb',
        args = { "--port", "${port}" },
      }
    }
    require('dap').configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    require('dap').configurations.c = require('dap').configurations.cpp
    require('dap.ext.vscode').json_decode = vim.fn.json_decode
  end },
   { 'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup {
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        all_frames = true,
        only_first_definition = false,
        all_references = true,
        virt_text_win_col = 60,
      }
    end }
  }

return M
