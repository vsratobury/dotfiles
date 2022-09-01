-- configure Spell
return {
  'lewis6991/spellsitter.nvim',
    requires = {
    },
    config = function()
    require('spellsitter').setup()
vim.api.nvim_create_augroup('Spell', { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*", -- disable spellchecking in the embeded terminal
      command = "setlocal nospell",
      group = 'Spell',
    })
    end
}
