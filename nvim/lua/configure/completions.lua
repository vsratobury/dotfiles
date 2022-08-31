-- nvim-cmp setup
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    'hrsh7th/nvim-cmp',
    requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-vsnip',
        'rafamadriz/friendly-snippets',
        'mtoohey31/cmp-fish',
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-y>'] = cmp.mapping.complete, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping({
                    i = cmp.mapping.confirm({ select = false, }),
                    c = cmp.mapping.confirm({ select = false, }),
                }),
                ['<C-n>'] = cmp.mapping(cmp.select_next_item(), { 'i', 'c' }),
                ['<C-p>'] = cmp.mapping(cmp.select_prev_item(), { 'i', 'c' }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if not cmp.visible() then
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
                { name = 'fish' }
            })
        })

        -- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline('/', {
        --     sources = {
        --         { name = 'buffer' }
        --     }
        -- })
        --
        -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        -- cmp.setup.cmdline(':', {
        --     sources = cmp.config.sources({
        --         { name = 'path' }
        --     }, {
        --         { name = 'cmdline' }
        --     })
        -- })
    end,
}
