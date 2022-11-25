augroup mygroup
    autocmd!

    autocmd TermOpen * startinsert
    autocmd TermOpen * :setlocal nonumber norelativenumber signcolumn=no

    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300, on_visual=false}
augroup end
