local map = vim.keymap.set

map('n', '<leader>gf', ':diffget //2<cr>')
map('n', '<leader>gj', ':diffget //3<cr>')
map('n', '<leader>gs', ':Git<cr>')
map('n', '<leader>ga', ':Git fetch --all<cr>')
map('n', '<leader>gp', ':Git pull<cr>')
