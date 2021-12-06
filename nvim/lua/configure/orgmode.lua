return {
    'kristijanhusak/orgmode.nvim',
    requires = {
        'nvim-treesitter/nvim-treesitter',
    },
    after = 'nvim-lspconfig',
    config = function()
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
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
    end,
}
