local map = vim.api.nvim_set_keymap

map('n', '<F4>', ':CMakeRun<cr>', {})
map('n', '<F5>', ':CMakeBuild<cr>', {})

local M = {
  -- fish file type support
  { 'ericvw/vim-fish' },

  -- Tex/LaTex file type support and compiling
  {
    'lervag/vimtex',
    config = function()
      vim.g['vimtex_view_method'] = 'skim'
      vim.g['tex_conceal'] = 'abdmg'
    end
  },

  { 'Civitasv/cmake-tools.nvim',
    config = function()
      require("cmake-tools").setup {
        cmake_command = "cmake",
        cmake_build_directory = "Debug",
        cmake_build_type = "Debug",
        cmake_generate_options = { "-G", "Ninja" },
        cmake_build_options = {},
        cmake_console_size = 10, -- cmake output window height
        cmake_show_console = "only_on_error", -- "always", "only_on_error"
        cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
        cmake_dap_open_command = require("dap").repl.open, -- optional
      }
    end }
}

vim.api.nvim_create_augroup('Language', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Language',
  pattern = { '*.go' },
  callback = function()
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Language',
  pattern = { 'CMake*' },
  command = '% !cmake-format -',
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'Language',
  pattern = { '*.fish' },
  command = ':lua vim.api.nvim_buf_set_option(0, \"commentstring\", \"# %s\")',
})

vim.api.nvim_create_autocmd('BufFilePost', {
  group = 'Language',
  pattern = { '*.fish' },
  command = ':lua vim.api.nvim_buf_set_option(0, \"commentstring\", \"# %s\")',
})

vim.api.nvim_create_autocmd('BufFilePost', {
  group = 'Language',
  pattern = { 'go' },
  command = 'set makeprg=go\\ test',
})

return M
