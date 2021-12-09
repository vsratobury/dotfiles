local M = {}

M.default = {
    { '<ESC>', '<C-\\><C-n>', mode = 't' },
    { '<Leader>', mode = 'n', {
        { 'q', ':q<cr>' },
        { 'Q', ':qa<cr>' },
        { 's', ':w<cr>' },
        { 'S', ':wa<cr>' },
        { 'c', ':bd<cr>' },
        { 'o', ':Telescope oldfiles<cr>' },
        { 'f', ':Telescope find_files<cr>' },
        { 'j', ':Telescope buffers<cr>' },
        { 'J', ':Telescope jumplist<cr>' },
        { 'fg', ':Telescope live_grep<cr>'}}
    }
}

return M

