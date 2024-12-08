require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
			'--hidden',
		},
	},
})

local builtin = require('telescope.builtin')
require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader><space>', builtin.git_files)
vim.keymap.set('n', '<leader>,', builtin.buffers)
vim.keymap.set('n', '<leader>.', builtin.find_files)
vim.keymap.set('n', '<leader>;', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>*', builtin.grep_string)
vim.keymap.set('n', '<leader>vh', builtin.help_tags)
