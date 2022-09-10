local M = {}

-- use TAB/S-TAB for select items in menu
vim.keymap.set('i', '<C-i>', function()
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
    { '<F2>', ':setlocal spell!<cr>' },
    { '<F3>', ':copen<cr>' },
    { '<F4>', ':CMakeRun<cr>' },
    { '<F5>', ':CMakeBuild<cr>' },
    { 'K', ':lua vim.lsp.buf.hover()<cr>' },
    { 'gd', ':lua vim.lsp.buf.definition()<cr>' } },
  -- with leader key
  { '<Leader>', mode = 'n', {
    { 't', ':vsplit +terminal<cr>' },
    { 'q', ':qa<cr>' },
    { 'Q', ':qa!<cr>' },
    { 's', ':wa<cr>' },
    { 'S', ':wa!<cr>' },
    { 'c', ':bd<cr>' },
    { 'C', ':bd!<cr>' },
    -- LSP functions
    { 'lf', ':lua vim.lsp.buf.formatting()<cr>' },
    { 'ld', ':lua vim.lsp.buf.lsp_code_action()<cr>' },
    { 'lm', ':lua vim.lsp.buf.rename()<cr>' },
    { ',', ':lua vim.lsp.diagnostic.goto_prev()<cr>' },
    { ';', ':lua vim.lsp.diagnostic.goto_next()<cr>' },
    -- telescope functions
    { 'p', ':lua require("telescope").extensions.project.project{ display_type = "full" }<cr>' },
    { 'o', ':Telescope oldfiles<cr>' },
    { 'f', ':Telescope find_files<cr>' },
    { 'j', ':Telescope buffers<cr>' },
    { 'J', ':Telescope jumplist<cr>' },
    { 'g', ':Telescope live_grep<cr>' },
    { 'b', ':Telescope current_buffer_fuzzy_find<cr>' },
    { 'lr', ':Telescope lsp_references<cr>' },
    { 'ls', ':Telescope lsp_document_symbols<cr>' },
    -- dap debug functions
    { 'ds',
      ':lua require("dap.ext.vscode").load_launchjs(nil, {codelldb = {"cpp", "c"}}); require("dap").continue()<cr>' },
    { 'dw', ':lua require("dap").repl.toggle()<cr>' },
    { 'dq', ':lua require("dap").terminate()<cr>:%db|e#<cr>' },
    { 'db', ':lua require("dap").toggle_breakpoint()<cr>' },
    { 'dl', ':lua require("dap").list_breakpoints()<cr>:copen<cr>' },
    { 'dc', ':lua require("dap").clear_breakpoints()<cr>' },
    { 'dr', ':lua require("dap").run_to_cursor()<cr>' },
  }
    -- {'i', '<cmd>ClangdSwitchSourceHeader<cr>'},
    -- {'lF', 'ggVG:!clang-format-mp-11 --style=llvm<cr>'},
  },
  -- disable all arrow keys!
  { mode = 'n', { '<Up>', '' }, { '<Down>', '' }, { '<Left>', '' }, { '<Right>', '' } },
  { mode = 'i', { '<Up>', '' }, { '<Down>', '' }, { '<Left>', '' }, { '<Right>', '' } },
  { mode = 'c', { '<Up>', '' }, { '<Down>', '' }, { '<Left>', '' }, { '<Right>', '' } }
}

return M
