-- autocommands.lua
--

-------------------- HELPERS -------------------------------
local cmd = vim.cmd
local fmt = string.format

-------------------- COMMANDS ------------------------------

function InitTerminalWindow()
  cmd 'setlocal nonumber norelativenumber'
  cmd 'setlocal nospell'
  cmd 'setlocal signcolumn=auto'
end

function GoImports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
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
end

vim.tbl_map(function(c) cmd(fmt('autocmd %s', c)) end, {
  'TermOpen * lua InitTerminalWindow()',
  'TextYankPost * lua vim.highlight.on_yank {timeout = 400, on_visual = false}',
  'BufWritePre *.go,*.h,*.hh,*.cc,*.c,*.cpp,*.lua, lua vim.lsp.buf.formatting_sync()',
  'BufWritePre *.go lua GoImports(1000)',
  'BufWritePre CMake* % !cmake-format -',
  'BufEnter *.fish :lua vim.api.nvim_buf_set_option(0, \"commentstring\", \"# %s\")',
  'BufFilePost *.fish :lua vim.api.nvim_buf_set_option(0, \"commentstring\", \"# %s\")',
  -- 'FileType go syntax sync fromstart; syntax on',
  'FileType go set makeprg=go\\ test',
})

