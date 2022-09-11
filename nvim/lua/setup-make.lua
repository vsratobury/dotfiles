local map = vim.api.nvim_set_keymap

map('n', '<F3>', ':copen<cr>', {})
map('n', '<F4>', ':CMakeRun<cr>', {})
map('n', '<F5>', ':CMakeBuild<cr>', {})

local M =
-- cmake interctive support
  { 'Civitasv/cmake-tools.nvim',
    config = function()
      require("cmake-tools").setup {
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_type = "Debug",
        cmake_generate_options = { "-G", "Ninja" },
        cmake_build_options = {},
        cmake_console_size = 10, -- cmake output window height
        cmake_show_console = "only_on_error", -- "always", "only_on_error"
        cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
        cmake_dap_open_command = require("dap").repl.open, -- optional
      }
    end }


return M
