return {
    'neovim/nvim-lspconfig',
    requires = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
                cmd = {"/Users/vsratobury/lualsp/bin/macOS/lua-language-server"},
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
        })
        do
            require('lspconfig')[ls].setup(cfg)
        end
    end
}
