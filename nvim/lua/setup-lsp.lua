local map = vim.api.nvim_set_keymap

map('n', '<leader>lf', ':lua vim.lsp.buf.formatting()<cr>', {})
map('n', '<leader>ld', ':lua vim.lsp.buf.lsp_code_action()<cr>', {})
map('n', '<leader>lm', ':lua vim.lsp.buf.rename()<cr>', {})
map('n', '<leader>l,', ':lua vim.lsp.diagnostic.goto_prev()<cr>', {})
map('n', '<leader>l;', ':lua vim.lsp.diagnostic.goto_next()<cr>', {})
map('n', 'K', ':lua vim.lsp.buf.hover()<cr>', {})
map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>', {})
map('n', '<C-h>', ':ClangdSwitchSourceHeader<cr>', {})
map('n', '<F12>', ':SymbolsOutline<cr>', {})

local M = {
  {
    'neovim/nvim-lspconfig',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      for ls, cfg in pairs({
        neocmake = {
          capabilities = capabilities
        },
        clangd = {
          capabilities = capabilities
        },
        gopls = {
          cmd = { "gopls", "serve" },
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
          capabilities = capabilities
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
          capabilities = capabilities
        },
        -- sumneko_lua = {
        --   cmd = { "/Users/vsratobury/.local/lualsp/bin/lua-language-server" },
        --   settings = {
        --     Lua = {
        --       runtime = {
        --         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        --         version = 'LuaJIT',
        --         -- Setup your lua path
        --         path = runtime_path,
        --         diagnostics = {
        --           globals = { "vim" }
        --         }
        --       },
        --       diagnostics = {
        --         -- Get the language server to recognize the `vim` global
        --         globals = { 'vim' },
        --       },
        --       workspace = {
        --         -- Make the server aware of Neovim runtime files
        --         library = vim.api.nvim_get_runtime_file("", true),
        --       },
        --       -- Do not send telemetry data containing a randomized but unique identifier
        --       telemetry = {
        --         enable = false,
        --       },
        --       format = {
        --         enable = true,
        --         -- Put format options here
        --         -- NOTE: the value should be STRING!!
        --         defaultConfig = {
        --           indent_style = "space",
        --           indent_size = "4",
        --         }
        --       },
        --     },
        --   },
        --   capabilities = capabilities
        -- },
      }) do
        require('lspconfig')[ls].setup(cfg)
      end
    end
  },

  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require('symbols-outline').setup()
    end
  }
}

-- START COPYPASTA https://github.com/neovim/neovim/commit/5b04e46d23b65413d934d812d61d8720b815eb1c
local util = require 'vim.lsp.util'
--- Formats a buffer using the attached (and optionally filtered) language
--- server clients.
---
--- @param options table|nil Optional table which holds the following optional fields:
---     - formatting_options (table|nil):
---         Can be d to specify FormattingOptions. Some unspecified options will be
---         automatically derived from the current Neovim options.
---         @see https://microsoft.github.io/language-server-protocol/specification#textDocument_formatting
---     - timeout_ms (integer|nil, default 1000):
---         Time in milliseconds to block for formatting requests. Formatting requests are current
---         synchronous to prevent editing of the buffer.
---     - bufnr (number|nil):
---         Restrict formatting to the clients attached to the given buffer, defaults to the current
---         buffer (0).
---     - filter (function|nil):
---         Predicate to filter clients d for formatting. Receives the list of clients attached
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

return M
