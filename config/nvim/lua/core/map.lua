vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set('x', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('x', 'K', ':m \'<-2<CR>gv=gv')
vim.keymap.set('x', '<S-Down>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('x', '<S-Up>', ':m \'<-2<CR>gv=gv')

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'x' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+y$]])

vim.keymap.set({ 'n', 'x' }, '<leader>d', [["_d]])

vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')
vim.keymap.set('n', '<C-Up>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-Down>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader><Up>', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader><Down>', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
vim.keymap.set('n', '<leader>w', ':execute "write" | !sync-directory<space><Up>')
vim.keymap.set('n', '<leader>e', ':e %:h/')
