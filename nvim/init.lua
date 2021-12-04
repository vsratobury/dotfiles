-- neovim config -- version 4
--

local api, fn, g = vim.api, vim.fn, vim.g
local fmt = string.format

------------------- RUN PARTS -------------------------------

require('pluggins')
require('options')
require('mappings')
require('autocommands')

-------------------- CONFIGURATION -------------------------------

-- onedark theme
require('onedark').setup()

-- fzf and fzf.vim
g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}

-- nvim-hardline
require('hardline').setup({
  bufferline = true,
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'med', item =  require('hardline.parts.keymap').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%<',
    {class = 'med', item = '%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'mode', item = require('hardline.parts.line').get_item},
  },
})

-- nvim-lspfuzzy
require('lspfuzzy').setup()
-- nvim-gps
require("nvim-gps").setup({
    icons = {
        ["class-name"] = ' ',      -- Classes and class-like objects
        ["function-name"] = '𝑓 ',   -- Functions
        ["method-name"] = 'µ ',     -- Methods (functions inside class-like objects)
        ["container-name"] = '≣ ',  -- Containers (example: lua tables)
        ["tag-name"] = '炙'         -- Tags (example: html tags)
    },
    -- Disable any languages individually over here
    -- Any language not disabled here is enabled by default
    languages = {
        -- ["bash"] = false,
        -- ["go"] = false,
    },
    separator = ' > ',
})

-- gitsigns.nvim
require('gitsigns').setup {
  signs = {
    add = {text = '+'},
    change = {text = '~'},
    delete = {text = '-'},
    topdelete = {text = '-'},
    changedelete = {text = '≃'},
  },
}

-- indent-blankline.nvim
g['indent_blankline_char'] = '┊'
g['indent_blankline_buftype_exclude'] = {'terminal'}
g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}

-- nvim-cmp setup
local cmp = require'cmp'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
 -- local snippy = require("snippy")
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ select = true, }),
      c = cmp.mapping.confirm({ select = false, }),
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'treesitter' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- vim-snippets setup

-- nvim-comment
require('nvim_comment').setup()
-- which-key
require('which-key').setup( {
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 30,
    }
  }
})

-- orgmode
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

-- orgmode
require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/inbox.org',
})

-------------------- LSP -----------------------------------

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

for ls, cfg in pairs({
  cmake = {
    capabilities = capabilities
  },
  clangd = {
    capabilities = capabilities
  },
  gopls = {
    cmd = {"gopls", "serve"},
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
  sumneko_lua = {
    cmd = {"/opt/local/bin/lua-language-server"},
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
          diagnostics = {
            globals = {"vim"}
          }
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
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
}) do require('lspconfig')[ls].setup(cfg) end

-------------------- TREE-SITTER ---------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed = {'go', 'cpp', 'c', 'lua', 'org', 'python', 'fish'},
  highlight = {
    enable = true, disable = {'org', 'go', 'c', 'cpp'},
    additional_vim_regex_highlighting = {'org'}
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
        ['ac'] = '@class.outer', ['ic'] = '@class.inner',
        ['ab'] = '@block.outer', ['ib'] = '@block.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      goto_next_start = {
        [']a'] = '@parameter.outer',
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
        [']*'] = '@comment.outer',
      },
      goto_next_end = {
        [']A'] = '@parameter.outer',
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[a'] = '@parameter.outer',
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
        ['[*'] = '@comment.outer',
      },
      goto_previous_end = {
        ['[A'] = '@parameter.outer',
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

