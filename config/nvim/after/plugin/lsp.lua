local lsp = require('lsp-zero').preset('system-lsp')

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    elseif client.name == 'bashls' then
        vim.keymap.set('n', '<leader>cf', '<cmd>%!shfmt -s -i 4<CR>', opts)
        vim.keymap.set('x', '<leader>cf', '!shfmt -s -i 4<CR>', opts)
    elseif client.name == 'eslint' then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', vim.cmd.EslintFixAll, opts)
    elseif client.supports_method('textDocument/formatting') then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
    end
end)

lsp.setup_servers({ 'bashls', 'cssls', 'dockerls', 'eslint', 'gopls', 'html', 'jdtls', 'jsonls', 'pylsp', 'rnix',
    'tailwindcss', 'yamlls' })

lsp.setup_servers({
    'hls',
    opts = {
        settings = {
            haskell = {
                cabalFormattingProvider = "cabalfmt",
                formattingProvider = "fourmolu",
            },
        },
    }
})

lsp.setup_servers({
    'tsserver',
    opts = {
        init_options = {
            tsserver = {
                path = vim.g.tsserver_path,
            },
        },
    }
})

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
