local lspconfig = require('lspconfig')
lspconfig.astro.setup({
    init_options = {
        typescript = {
            tsdk = vim.g.tsserver_path,
        },
    },
})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.clojure_lsp.setup({})
lspconfig.cssls.setup({})
lspconfig.dockerls.setup({})
lspconfig.eslint.setup({})
lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
        },
    },
})
lspconfig.html.setup({})
lspconfig.jsonls.setup({})
lspconfig.nixd.setup({})
lspconfig.pylsp.setup({})
lspconfig.rust_analyzer.setup({
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = 'clippy',
            },
        },
    },
})
lspconfig.tailwindcss.setup({})
lspconfig.ts_ls.setup({
    init_options = {
        plugins = {
            {
                name = '@astrojs/ts-plugin',
                location = vim.g.astro_plugin_path,
            },
        },
        tsserver = {
            path = vim.g.tsserver_path,
        },
    },
})
lspconfig.yamlls.setup({})
lspconfig.zls.setup({})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        style = 'minimal',
        border = 'rounded',
        source = true,
        header = '',
        prefix = '',
    },
})
