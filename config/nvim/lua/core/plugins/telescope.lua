local map = vim.keymap.set
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local git_worktree = require('git-worktree')
local refactoring = require('refactoring')

telescope.setup({
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = ' >',
        color_devicons = true,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})
git_worktree.setup({})

telescope.load_extension('git_worktree')
telescope.load_extension('fzy_native')
telescope.load_extension('refactoring')

local function git_branches()
    builtin.git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end,
    })
end

map('n', '<leader><space>', function() builtin.git_files() end, {silent = true})
map('n', '<leader>,', function() builtin.buffers() end, {silent = true})
map('n', '<leader>.', function() builtin.find_files() end, {silent = true})
map('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input('Grep For > ')}) end, {silent = true})
map('n', '<leader>pw', function() builtin.grep_string { search = vim.fn.expand('<cword>') } end, {silent = true})
map('n', '<leader>vh', function() builtin.help_tags() end, {silent = true})

map('n', '<leader>gw', function() telescope.extensions.git_worktree.git_worktrees() end, {silent = true})
map('n', '<leader>gm', function() telescope.extensions.git_worktree.create_git_worktree() end, {silent = true})
map('n', '<leader>gc', git_branches, {silent = true})

map('x', '<leader>rr', function() telescope.extensions.refactoring.refactors() end, {silent = true})
map('n', '<leader>rr', function() telescope.extensions.refactoring.refactors() end, {silent = true})
map('n', '<leader>lf', function() refactoring.debug.printf({below = false}) end, {silent = true})
map('n', '<leader>lb', function() refactoring.debug.printf({below = true}) end, {silent = true})
