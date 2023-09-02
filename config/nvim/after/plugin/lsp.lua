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

    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)

    vim.keymap.set('n', 'gl', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

    if client.name == 'tsserver' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    elseif client.name == 'eslint' then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', vim.cmd.EslintFixAll, opts)
    elseif client.supports_method('textDocument/formatting') then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
    end
end)

lsp.setup_servers({ 'bashls', 'cssls', 'dockerls', 'eslint', 'gopls', 'html', 'jdtls', 'jsonls', 'pylsp', 'rnix',
    'tailwindcss', 'yamlls' })

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
