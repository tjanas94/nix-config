require('trouble').setup()

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})

local map = require('core.lib.keymap').map

map('n', '<leader>/', ':TroubleToggle<cr>')
map('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<cr>')
map('n', '<leader>xd', ':TroubleToggle document_diagnostics<cr>')
map('n', '<C-q>', ':TroubleToggle quickfix<cr>')
map('n', '<leader>q', ':TroubleToggle loclist<cr>')
map('n', 'gR', ':TroubleToggle lsp_references<cr>')

map('n', '<C-k>', ':cnext<cr>zz')
map('n', '<C-j>', ':cprev<cr>zz')
map('n', '<leader>k', ':lnext<cr>zz')
map('n', '<leader>j', ':lprev<cr>zz')
