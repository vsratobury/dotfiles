-- autocommands.lua
--

-------------------- HELPERS -------------------------------
local cmd = vim.cmd
local fmt = string.format

-------------------- COMMANDS ------------------------------

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

vim.api.nvim_create_augroup('Others', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  group = 'Others',
  pattern = { '*' },
  callback = function()
    cmd 'setlocal nonumber norelativenumber'
    cmd 'setlocal nospell'
    cmd 'setlocal signcolumn=auto'
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'Others',
  pattern = { '*' },
  command = '%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'Others',
  pattern = { '*' },
  callback = function()
    vim.highlight.on_yank { timeout = 400, on_visual = false }
  end,
})

-- vim.api.nvim_create_augroup('packer_user_config', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   group = 'packer_user_config',
--   pattern = { '*.lua' },
--   command = 'PackerCompile',
-- })

-- START COPYPASTA https://github.com/neovim/neovim/commit/5b04e46d23b65413d934d812d61d8720b815eb1c
local util = require 'vim.lsp.util'
--- Formats a buffer using the attached (and optionally filtered) language
--- server clients.
---
--- @param options table|nil Optional table which holds the following optional fields:
---     - formatting_options (table|nil):
---         Can be used to specify FormattingOptions. Some unspecified options will be
---         automatically derived from the current Neovim options.
---         @see https://microsoft.github.io/language-server-protocol/specification#textDocument_formatting
---     - timeout_ms (integer|nil, default 1000):
---         Time in milliseconds to block for formatting requests. Formatting requests are current
---         synchronous to prevent editing of the buffer.
---     - bufnr (number|nil):
---         Restrict formatting to the clients attached to the given buffer, defaults to the current
---         buffer (0).
---     - filter (function|nil):
---         Predicate to filter clients used for formatting. Receives the list of clients attached
---         to bufnr as the argument and must return the list of clients on which to request
---         formatting. Example:
---
---         <pre>
---         -- Never request typescript-language-server for formatting
---         vim.lsp.buf.format {
---           filter = function(clients)
---             return vim.tbl_filter(
---               function(client) return client.name ~= "tsserver" end,
---               clients
---             )
---           end
---         }
---         </pre>
---
---     - id (number|nil):
---         Restrict formatting to the client with ID (client.id) matching this field.
---     - name (string|nil):
---         Restrict formatting to the client with name (client.name) matching this field.
vim.lsp.buf.format = function(options)
  options = options or {}
  local bufnr = options.bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.buf_get_clients(bufnr)

  if options.filter then
    clients = options.filter(clients)
  elseif options.id then
    clients = vim.tbl_filter(
      function(client) return client.id == options.id end,
      clients
    )
  elseif options.name then
    clients = vim.tbl_filter(
      function(client) return client.name == options.name end,
      clients
    )
  end

  clients = vim.tbl_filter(
    function(client) return client.supports_method 'textDocument/formatting' end,
    clients
  )

  if #clients == 0 then
    vim.notify '[LSP] Format request failed, no matching language servers.'
  end

  local timeout_ms = options.timeout_ms or 1000
  for _, client in pairs(clients) do
    local params = util.make_formatting_params(options.formatting_options)
    local result, err = client.request_sync('textDocument/formatting', params, timeout_ms, bufnr)
    if result and result.result then
      util.apply_text_edits(result.result, bufnr, client.offset_encoding)
    elseif err then
      vim.notify(string.format('[LSP][%s] %s', client.name, err), vim.log.levels.WARN)
    end
  end
end
-- END COPYPASTA

vim.api.nvim_create_augroup('LspFormatting', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = 'LspFormatting',
  callback = function()
    vim.lsp.buf.format {
      timeout_ms = 2000,
      filter = function(clients)
        return vim.tbl_filter(function(client)
          return pcall(function(_client)
            return _client.config.settings.autoFixOnSave or false
          end, client) or false
        end, clients)
      end
    }
  end
})
