local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
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

    if client.name == 'bashls' then
        vim.keymap.set('n', '<leader>cf', '<cmd>%!shfmt -s -i 4<CR>', opts)
        vim.keymap.set('x', '<leader>cf', '!shfmt -s -i 4<CR>', opts)
    elseif client.name == 'clojure_lsp' then
        vim.keymap.set('n', '<leader>cf', '<cmd>%!joker --format -<CR>', opts)
        vim.keymap.set('x', '<leader>cf', '!joker --format -<CR>', opts)
    elseif client.name == 'eslint' then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', vim.cmd.EslintFixAll, opts)
    elseif client.supports_method('textDocument/formatting') then
        vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
    end
end)

lsp_zero.setup_servers({ 'astro', 'bashls', 'clojure_lsp', 'cssls', 'dockerls', 'eslint', 'gopls', 'html', 'jdtls',
    'jsonls', 'nixd', 'pylsp', 'tailwindcss', 'yamlls' })

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
lspconfig.tsserver.setup({
    init_options = {
        tsserver = {
            path = vim.g.tsserver_path,
        },
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end,
})

lsp_zero.set_sign_icons({
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
})

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format()

require('luasnip.loaders.from_vscode').lazy_load()

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

cmp.setup({
    formatting = cmp_format,
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    window = {
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = 'conjure' },
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
        -- confirm completion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- toggle completion menu
        ['<C-e>'] = cmp_action.toggle_completion(),

        -- navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- scroll documentation window
        ['<C-d>'] = cmp.mapping.scroll_docs(5),
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),
    }),
})
