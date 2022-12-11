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

local function git_branches()
    builtin.git_branches({
        attach_mappings = function(_, map)
            map('i', '<C-d>', actions.git_delete_branch)
            map('n', '<C-d>', actions.git_delete_branch)
            return true
        end,
    })
end

local map = require('core.lib.keymap').map

map('n', '<leader><space>', function() builtin.git_files() end)
map('n', '<leader>,', function() builtin.buffers() end)
map('n', '<leader>.', function() builtin.find_files() end)
map('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input('Grep For > ') }) end)
map('n', '<leader>pw', function() builtin.grep_string({ search = vim.fn.expand('<cword>') }) end)
map('n', '<leader>ph', function() builtin.help_tags() end)
map('n', '<leader>gc', git_branches)
