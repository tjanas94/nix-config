local map = vim.keymap.set
local harpoon = require('harpoon')
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
local cmd_ui = require('harpoon.cmd-ui')
local tmux = require('harpoon.tmux')

harpoon.setup({})

map('n', '<leader>ha', function() mark.add_file() end, {silent = true})
map('n', '<leader>hc', function() ui.toggle_quick_menu() end, {silent = true})
map('n', '<leader>tc', function() cmd_ui.toggle_quick_menu() end, {silent = true})

map('n', '<leader>hj', function() ui.nav_file(1) end, {silent = true})
map('n', '<leader>hk', function() ui.nav_file(2) end, {silent = true})
map('n', '<leader>hl', function() ui.nav_file(3) end, {silent = true})
map('n', '<leader>h;', function() ui.nav_file(4) end, {silent = true})
map('n', '<leader>tj', function() tmux.gotoTerminal(1) end, {silent = true})
map('n', '<leader>cj', function() tmux.sendCommand(1, 1) end, {silent = true})
map('n', '<leader>tk', function() tmux.gotoTerminal(2) end, {silent = true})
map('n', '<leader>ck', function() tmux.sendCommand(1, 2) end, {silent = true})
