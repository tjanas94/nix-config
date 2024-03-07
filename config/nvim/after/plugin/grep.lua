vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat:prepend({
    '%f:%l:%c:%m',
})

vim.api.nvim_create_user_command('Grep', 'copen | silent! grep! <args>', {
    nargs = '+',
})

vim.keymap.set('n', '<leader>v/', [[:Grep<space>''<left>]])

