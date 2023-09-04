require('trouble').setup({
    icons = false
})

vim.keymap.set('n', '<leader>vq', '<cmd>TroubleToggle quickfix<CR>',
    { silent = true, noremap = true }
)
