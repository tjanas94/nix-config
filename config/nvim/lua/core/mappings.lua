local map = require('core.lib.keymap').map

map('n', 'c', '"_c')
map('x', 'c', '"_c')
map('n', 'cc', '"_S')
map('n', 'C', '"_C')
map('x', 'C', '"_C')
map('n', 's', '"_s')
map('x', 's', '"_s')
map('n', 'S', '"_S')
map('x', 'S', '"_S')

map('x', 'J', ':m \'>+1<cr>gv=gv')
map('x', 'K', ':m \'<-2<cr>gv=gv')

map('n', 'Y', 'yg$')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

map('n', '<leader>s', '<plug>(SubversiveSubstitute)')
map('x', '<leader>s', '<plug>(SubversiveSubstitute)')
map('n', '<leader>ss', '<plug>(SubversiveSubstituteLine)')
map('n', '<leader>S', '<plug>(SubversiveSubstituteToEndOfLine)')

map('n', 'Q', '<nop>')

map('n', '<leader>u', ':UndotreeToggle<cr>')
map('n', '<leader>pv', ':Ex<cr>')
