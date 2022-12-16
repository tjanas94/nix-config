local lsp_servers = { 'bashls', 'cssls', 'dockerls', 'eslint', 'golangci_lint_ls', 'gopls', 'html', 'jsonls',
    'stylelint_lsp', 'sumneko_lua', 'tailwindcss', 'tsserver', 'yamlls' }

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
    gopls = {
        settings = {
            gopls = {
                gofumpt = true,
            },
        },
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
                path = vim.g.tsserver_path,
            },
        },
    },
}

local on_attach = function(_, bufnr)
    local bufmap = require('core.lib.keymap').bufmap(bufnr)

    bufmap('n', 'K', vim.lsp.buf.hover)
    bufmap('n', 'gd', vim.lsp.buf.definition)
    bufmap('n', 'gD', vim.lsp.buf.declaration)
    bufmap('n', 'gi', vim.lsp.buf.implementation)
    bufmap('n', 'go', vim.lsp.buf.type_definition)
    bufmap('n', 'gr', vim.lsp.buf.references)
    bufmap('n', '<leader>K', vim.lsp.buf.signature_help)
    bufmap('n', '<leader>rn', vim.lsp.buf.rename)
    bufmap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
    bufmap('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
    bufmap('n', 'gl', vim.diagnostic.open_float)
    bufmap('n', '[d', vim.diagnostic.goto_prev)
    bufmap('n', ']d', vim.diagnostic.goto_next)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end,
    })
    vim.api.nvim_create_autocmd('DiagnosticChanged', {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.setloclist({ open = false })
        end,
    })
end

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

for _, name in ipairs(lsp_servers) do
    local config = servers[name] or {}
    config.on_attach = on_attach
    lspconfig[name].setup(config)
end

local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    on_attach = on_attach,
    sources = {
        formatting.alejandra,
        formatting.fixjson,
        formatting.prettierd,
        formatting.shfmt,
        diagnostics.statix,
        code_actions.statix,
        code_actions.gitsigns,
        code_actions.gitrebase,
    },
})
