vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.updatetime = 50

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.completeopt = { 'menuone', 'noselect' }

vim.filetype.add({
    extension = {
        cdt = 'javascript',
        ctp = 'php',
        handlebars = 'handlebars',
        jqtpl = 'html',
    },
})
