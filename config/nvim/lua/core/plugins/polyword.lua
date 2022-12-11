local map = require('core.lib.keymap').map

map('n', '<leader>w', '<plug>(polyword-miniword-w)')
map('n', '<leader>b', '<plug>(polyword-miniword-b)')
map('n', '<leader>e', '<plug>(polyword-miniword-e)')
map('n', '<leader>ge', '<plug>(polyword-miniword-ge)')
map('o', 'im', '<plug>(polyword-miniword-iw)')
map('o', 'am', '<plug>(polyword-miniword-aw)')

map('n', '<leader>W', '<plug>(polyword-megaword-w)')
map('n', '<leader>B', '<plug>(polyword-megaword-b)')
map('n', '<leader>E', '<plug>(polyword-megaword-e)')
map('n', '<leader>gE', '<plug>(polyword-megaword-ge)')
map('o', 'iM', '<plug>(polyword-megaword-iw)')
map('o', 'aM', '<plug>(polyword-megaword-aw)')
