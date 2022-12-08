local group = vim.api.nvim_create_augroup('mygroup', {})

vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    command = 'setlocal nonumber norelativenumber signcolumn=no',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 300, on_visual = false })
    end,
})
