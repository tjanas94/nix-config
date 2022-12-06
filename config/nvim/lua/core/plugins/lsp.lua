local lsp = vim.lsp
local lsp_servers = { 'bashls', 'cssls', 'dockerls', 'eslint', 'golangci_lint_ls', 'gopls', 'html', 'jsonls',
    'stylelint_lsp', 'sumneko_lua', 'tailwindcss', 'tsserver', 'yamlls' }

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
    eslint = {
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
        end,
    },
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    tsserver = {
        settings = {
            diagnostics = {
                ignoredCodes = { 80001 },
            },
        },
        init_options = {
            tsserver = {
                path = vim.fn.expand('~/.local/lib/node_modules/typescript/lib/tsserver.js'),
            },
        },
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
        end,
    },
}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

for _, name in ipairs(lsp_servers) do
    lspconfig[name].setup(servers[name] or {})
end

local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    }, {
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'path' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer' },
    })
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local map = vim.keymap.set
local opts = { silent = true, noremap = true }
map('n', '<leader>vf', function() lsp.buf.format({ async = true }) end, opts)
map('n', '<leader>vd', function() lsp.buf.definition() end, opts)
map('n', '<leader>vi', function() lsp.buf.implementation() end, opts)
map('n', '<leader>vsh', function() lsp.buf.signature_help() end, opts)
map('n', '<leader>vrr', function() lsp.buf.references() end, opts)
map('n', '<leader>vrn', function() lsp.buf.rename() end, opts)
map('n', '<leader>vh', function() lsp.buf.hover() end, opts)
map('n', '<leader>vca', function() lsp.buf.code_action() end, opts)
map('n', '<leader>vsd', function() lsp.diagnostic.show_line_diagnostics() end, opts)
map('n', '<leader>vn', function() lsp.diagnostic.goto_next() end, opts)
map('n', '<leader>vll', function() lsp.diagnostic.set_loclist({ open_loclist = false }) end, opts)
