local map = require('core.lib.keymap').map

map('n', '<leader>gf', ':diffget //2<cr>')
map('n', '<leader>gj', ':diffget //3<cr>')
map('n', '<leader>gs', ':Git<cr>')
map('n', '<leader>ga', ':Git fetch --all<cr>')
map('n', '<leader>gp', ':Git pull<cr>')

map('n', '<leader>gll', ':let g:_search_term = expand("%")<cr><bar>:Gclog -- %<cr>:call search(g:_search_term)<cr>')
map('n', '<leader>gln', ':cnext<cr>:call search(_search_term)<cr>')
map('n', '<leader>glp', ':cprev<cr>:call search(_search_term)<cr>')
