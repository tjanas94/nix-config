local g = vim.g
local opt = vim.opt

g.mapleader = ' '

g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25

opt.cmdheight = 1
opt.colorcolumn = '100'
opt.clipboard:append('unnamed,unnamedplus')
opt.guicursor = {}
opt.hidden = true
opt.iskeyword:append('-')
opt.scrolloff = 8
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.shortmess:append('c')
opt.termguicolors = true
opt.wrap = false
opt.updatetime = 50

opt.number = true
opt.numberwidth = 5
opt.relativenumber = true
opt.signcolumn = 'yes'

opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.hlsearch = false
opt.incsearch = true

opt.backup = false
opt.swapfile = false
opt.undofile = true

opt.path:append('**')
opt.wildmenu = true
opt.wildmode = { 'longest', 'list', 'full' }

opt.completeopt = { 'menu', 'menuone', 'noselect' }
g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
