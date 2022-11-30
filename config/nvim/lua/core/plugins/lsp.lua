local lsp = vim.lsp
local lsp_servers = { 'bashls', 'cssls', 'dockerls', 'eslint', 'html', 'jsonls', 'sumneko_lua', 'tailwindcss', 'tsserver', 'yamlls' }

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
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
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    tsserver = {
        init_options = {
            tsserver = {
                path = vim.fn.expand('$HOME/.nix-profile/lib/node_modules/typescript/lib/tsserver.js'),
            },
        },
    },
}

local lspconfig = require('lspconfig')

for _, name in ipairs(lsp_servers) do
    local opts = servers[name] or {}
    opts.capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig[name].setup(opts)
end

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
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
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
})

require('luasnip.loaders.from_vscode').load()
require('symbols-outline').setup()

local map = vim.keymap.set
map('n', '<leader>vd', function() lsp.buf.definition() end)
map('n', '<leader>vi', function() lsp.buf.implementation() end)
map('n', '<leader>vsh', function() lsp.buf.signature_help() end)
map('n', '<leader>vrr', function() lsp.buf.references() end)
map('n', '<leader>vrn', function() lsp.buf.rename() end)
map('n', '<leader>vh', function() lsp.buf.hover() end)
map('n', '<leader>vca', function() lsp.buf.code_action() end)
map('n', '<leader>vsd', function() lsp.diagnostic.show_line_diagnostics() end)
map('n', '<leader>vn', function() lsp.diagnostic.goto_next() end)
map('n', '<leader>vll', function() lsp.diagnostic.set_loclist({open_loclist = false}) end)
vim.cmd("command! Format execute 'lua vim.lsp.buf.formatting()")
