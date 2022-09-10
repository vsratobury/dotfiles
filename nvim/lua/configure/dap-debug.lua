return {
  'mfussenegger/nvim-dap', config = function()
    require('dap').adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        -- CHANGE THIS to your path!
        command = '/Users/vsratobury/.tools/codelldb/extension/adapter/codelldb',
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
  end
}
