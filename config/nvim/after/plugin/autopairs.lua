local autopairs = require('nvim-autopairs')

autopairs.setup({
    disable_filetype = { 'TelescopePrompt' }
})
autopairs.get_rules("'")[1].not_filetypes = { 'clojure' }
autopairs.get_rules("`")[1].not_filetypes = { 'clojure' }
