vim.g.dispatch_compilers = {
    eslint = 'eslint',
}

vim.keymap.set('n', '<leader>cdef', '<cmd>Dispatch eslint --format=compact %<cr>')
vim.keymap.set('n', '<leader>cdep', '<cmd>Dispatch eslint --format=compact .<cr>')
vim.keymap.set('n', '<leader>cdjf', '<cmd>Dispatch jest --coverage=false %<cr>')
vim.keymap.set('n', '<leader>cdjp', '<cmd>Dispatch jest --coverage=false .<cr>')
vim.keymap.set('n', '<leader>cdt', '<cmd>Dispatch tsc -p tsconfig.eslint.json<cr>')
