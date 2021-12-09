return {
    'LionC/nest.nvim',
    config = function()
        local keymap = require('keymaps')
        require('nest').applyKeymaps(keymap.default)
    end
}
