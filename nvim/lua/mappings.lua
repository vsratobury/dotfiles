-- mappings.lua
--

-------------------- HELPERS -------------------------------
local api, cmd, g = vim.api, vim.cmd, vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- MAPPINGS ------------------------------

-- map leader key
map('n', '<Space>', '', {nowait = true})
g.mapleader = ' '

-- FZF mappings
map('n', '<leader>/', '<cmd>Lines<CR>')
map('n', '<leader>:', '<cmd>History:<CR>')
map('n', '<leader>e', '<cmd>Telescope fd<CR>')
map('n', '<leader>g', '<cmd>Rg<CR>')
map('n', '<leader>j', '<cmd>Buffers<CR>')
map('n', '<leader>w', '<cmd>Windows<CR>')
map('n', '<leader>c', '<cmd>Commands<CR>')

-- LSP mappings new
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>lF', 'ggVG:!clang-format-mp-11 --style=llvm<CR>')
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>lm', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', '<leader>i', '<cmd>ClangdSwitchSourceHeader<CR>')
map('n', '<leader>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>li', '<cmd>cexpr system("golint ./...")<cr>')

-- change working directory to file in buffer
map('n', '<leader>d', '<cmd>cd %:p:h<cr><cmd>pwd<cr>', { silent = false})

-- edit main config
map('n', '<leader>c', '<cmd>e $MYVIMRC<cr>')

-- buffer operation
map('n', '<leader>bd', '<cmd>bd<cr>')
map('n', '<leader>bn', '<cmd>bn<cr>')
map('n', '<leader>bp', '<cmd>bp<cr>')

-- C-Space - change keyboard layout
map('n', '<C-Space>', 'i<C-^><C-c>', { noremap = true, silent = true } )
map('i', '<C-Space>', '<C-^>', { noremap = true, silent = true } )
map('c', '<C-Space>', '<C-^>', { noremap = true, silent = true } )

-- use TAB/S-TAB for select items in menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- enable/disable spelling
map('n', '<leader>s', ':set spell!<CR>', {noremap = true})

-- <esc> for swith normal mode in terminal
map('n', '<leader>t', ':terminal<CR>', {noremap = true, silent = true})
map('t', '<Esc>', '<C-\\><C-N>', {noremap = true})
map('t', '<C-[>', '<C-\\><C-N>', {noremap = true})

-- new line
map('n', '<C-j>', 'a<CR><Esc>', {noremap = true, silent = true})

-- keyboard cancel
map('i', '<C-c>', '<Esc>', {noremap = true, silent = true})

-- cmake mappings
HasCMakeWindowOpen = false
function SwitchCMakeWindow()
  if HasCMakeWindowOpen then
    HasCMakeWindowOpen = false
    cmd [[ CMakeClose ]]
  else
    HasCMakeWindowOpen = true
    cmd [[ CMakeOpen ]]
    cmd [[ wincmd j ]]
  end
end
map('n', '<F2>', '<cmd>lua SwitchCMakeWindow()<cr>', {noremap = true})
map('n', '<F5>', '<cmd>make<cr>')

-- compile result window
HasErrorsWindowOpen = false
function SwitchErrorsWindow()
  if HasErrorsWindowOpen then
    HasErrorsWindowOpen = false
    cmd [[ cclose ]]
  else
    HasErrorsWindowOpen = true
    cmd [[ copen ]]
  end
end
map('n', '<F3>', '<cmd>lua SwitchErrorsWindow()<cr>', {noremap = true})
map('n', '<leader>n', '<cmd>cnext<cr>', {noremap = true})
map('n', '<leader>N', '<cmd>cprev<cr>', {noremap = true})

-- browse $MYPROJECTS dir
map('n', '<leader>P', '<cmd>e $MYPROJECTS<cr>', {noremap = true})

-- browse current directory
map('n', '<leader>.', '<cmd>e .<cr>', {noremap = true})

-- git fugitive
map('n', '<leader>v', '<cmd>Git<cr>', {noremap = true})

-- for study purpose disable all arrow buttons
map('n', '<Up>', '', {noremap = true })
map('i', '<Up>', '', {noremap = true})
map('c', '<Up>', '', {noremap = true})
map('n', '<Down>', '', {noremap = true })
map('i', '<Down>', '', {noremap = true})
map('c', '<Down>', '', {noremap = true})
map('n', '<Left>', '', {noremap = true })
map('i', '<Left>', '', {noremap = true})
map('c', '<Left>', '', {noremap = true})
map('n', '<Right>', '', {noremap = true })
map('i', '<Right>', '', {noremap = true})
map('c', '<Right>', '', {noremap = true})

