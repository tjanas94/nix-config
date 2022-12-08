local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local trouble = require('trouble.providers.telescope')

telescope.setup({
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
                ['<C-q>'] = actions.send_to_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist,
                ['<C-t>'] = trouble.open_with_trouble,
            },
            n = {
                ['<C-q>'] = actions.send_to_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist,
                ['<C-t>'] = trouble.open_with_trouble,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

telescope.load_extension('fzy_native')
require('trouble').setup()

local function git_branches()
    builtin.git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end,
    })
end

local map = vim.keymap.set
local opts = { silent = true, noremap = true }
map('n', '<leader><space>', function() builtin.git_files() end, opts)
map('n', '<leader>,', function() builtin.buffers() end, opts)
map('n', '<leader>.', function() builtin.find_files() end, opts)
map('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input('Grep For > ') }) end, opts)
map('n', '<leader>pw', function() builtin.grep_string { search = vim.fn.expand('<cword>') } end, opts)
map('n', '<leader>ph', function() builtin.help_tags() end, opts)
map('n', '<leader>gc', git_branches, opts)

map('n', '<leader>xx', ':TroubleToggle<cr>', opts)
map('n', '<leader>xw', ':TroubleToggle workspace_diagnostics<cr>', opts)
map('n', '<leader>xd', ':TroubleToggle document_diagnostics<cr>', opts)
map('n', '<C-q>', ':TroubleToggle quickfix<cr>', opts)
map('n', '<leader>q', ':TroubleToggle loclist<cr>', opts)
map('n', 'gR', ':TroubleToggle lsp_references<cr>', opts)

map('n', '<C-k>', ':cnext<cr>zz', opts)
map('n', '<C-j>', ':cprev<cr>zz', opts)
map('n', '<leader>k', ':lnext<cr>zz', opts)
map('n', '<leader>j', ':lprev<cr>zz', opts)

map('n', '<leader>gll', ':let g:_search_term = expand("%")<cr><bar>:Gclog -- %<cr>:call search(g:_search_term)<cr>', opts)
map('n', '<leader>gln', ':cnext<cr>:call search(_search_term)<cr>', opts)
map('n', '<leader>glp', ':cprev<cr>:call search(_search_term)<cr>', opts)
