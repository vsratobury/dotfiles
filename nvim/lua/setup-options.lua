-- options.lua
--

-------------------- HELPERS -------------------------------
local cmd = vim.cmd
local opt = vim.opt

-------------------- OPTIONS -------------------------------

cmd [[lang en_US.UTF-8]]            -- Setup LANG

local indent, width = 2, 80
opt.hidden = true                   -- Allow hide modified buffers
opt.colorcolumn = tostring(width)   -- Line length marker
opt.completeopt = {'menuone', 'noinsert'}  -- Completion options
opt.cursorline = true               -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.formatoptions = 'croqnj'        -- Automatic formatting options
opt.ignorecase = true               -- Ignore case
opt.inccommand = ''                 -- Disable substitution preview
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
-- opt.pastetoggle = '<F12>'            -- Paste mode
opt.pumheight = 12                  -- Max height of popup menu
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 10                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent             -- Size of an indent
opt.shortmess = 'atToOFc'           -- Prompt message options
opt.sidescrolloff = 8               -- Columns of context
opt.signcolumn = 'yes'              -- Show sign column
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.textwidth = width               -- Maximum width of text
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.spelllang = 'en_us,ru_yo'       -- Spell languages
opt.keymap = 'russian-jcukenmac'    -- Russian key map
opt.iminsert = 0                    -- default english key map
opt.path = opt.path + './lua'       -- search files in lua dir
opt.mouse = 'nv'                    -- enable mouse
opt.conceallevel = 1
opt.laststatus = 3

if vim.env.TERM == 'xterm-kitty' then
    opt.termguicolors = true        -- True color support
end
-- cmd([[let &t_ut='']])               -- Color bug for kitty

-- setup syntax highlighting for go --
--
vim.g['go_fold_enable'] = {'block', 'commnet'} --['block', 'import', 'varconst', 'package_comment'])
vim.g['go_highlight_array_whitespace_error'] = 1 --0)
vim.g['go_highlight_chan_whitespace_error'] =1 --0)
vim.g['go_highlight_extra_types'] =1 --0)
vim.g['go_highlight_space_tab_error'] =1 --0)
vim.g['go_highlight_trailing_whitespace_error'] =1 --0)
-- vim.g['go_highlight_operators'] =1 --0)
vim.g['go_highlight_functions'] =1 --0)
vim.g['go_highlight_function_parameters'] =1 --0)
vim.g['go_highlight_function_calls'] =1 --0)
vim.g['go_highlight_fields'] =1 --0)
vim.g['go_highlight_types'] =1 --0)
vim.g['go_highlight_build_constraints'] =1 --0)
-- vim.g['go_highlight_string_spellcheck'] --1)
-- vim.g['go_highlight_format_strings'] --1)
vim.g['go_highlight_generate_tags'] =1 --0)
vim.g['go_highlight_variable_assignments'] =1 --0)
vim.g['go_highlight_variable_declarations'] =1 --0)
