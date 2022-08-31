local M = {}

-- use TAB/S-TAB for select items in menu
vim.keymap.set('i', '<Tab>', function()
         return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
       end, { expr = true })

M.default = {
    { '<ESC>', '<C-\\><C-n>', mode = 't' },
    -- change keymap
    { '<C-Space>', 'i<C-^><ESC>', mode = 'n' },
    { '<C-Space>', '<C-^>', mode = 'i' },
    { '<C-Space>', '<C-^><ESC>', mode = 'c' },
    -- functional keys
    { mode = 'n',
    { '<F2>', ':set spell!' },
    {'K', ':lua vim.lsp.buf.hover()<cr>'},
    {'gd', ':lua vim.lsp.buf.definition()<cr>'},
    {',', ':lua vim.lsp.diagnostic.goto_prev()<cr>'},
    {';', ':lua vim.lsp.diagnostic.goto_next()<cr>'}},
    -- with leader key
    { '<Leader>', mode = 'n', {
        { 'q', ':q<cr>' },
        { 'Q', ':qa<cr>' },
        { 's', ':w<cr>' },
        { 'S', ':wa<cr>' },
        { 'c', ':bd<cr>' },
        { 'p', ':lua require("telescope").extensions.project.project{ display_type = "full" }<cr>' },
        { 'o', ':Telescope oldfiles<cr>' },
        { 'f', ':Telescope find_files<cr>' },
        { 'j', ':Telescope buffers<cr>' },
        { 'J', ':Telescope jumplist<cr>' },
        { 'fg', ':Telescope live_grep<cr>'},
        { 'lf', ':lua vim.lsp.buf.formatting()<cr>'},
        { 'ld', ':lua vim.lsp.buf.lsp_code_action()<cr>'},
        { 'lm', ':lua vim.lsp.buf.rename()<cr>'},
        { 'lr', ':Telescope lsp_references<cr>'},
        { 'ls', ':Telescope lsp_document_symbols<cr>'}}
        -- {'i', '<cmd>ClangdSwitchSourceHeader<cr>'},
        -- {'lF', 'ggVG:!clang-format-mp-11 --style=llvm<cr>'},
    },
    -- disable all arrow keys!
    { mode = 'n', {'<Up>', ''}, {'<Down>', ''}, {'<Left>', ''}, {'<Right>', ''}},
    { mode = 'i', {'<Up>', ''}, {'<Down>', ''}, {'<Left>', ''}, {'<Right>', ''}},
    { mode = 'c', {'<Up>', ''}, {'<Down>', ''}, {'<Left>', ''}, {'<Right>', ''}}
}

return M

