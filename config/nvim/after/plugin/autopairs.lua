local autopairs = require('nvim-autopairs')
local lisps = { 'clojure', 'fennel', 'lisp', 'scheme' }

autopairs.setup({
    ignored_next_char = "",
    enable_check_bracket_line = false,
})
autopairs.get_rules("'")[1].not_filetypes = lisps
autopairs.get_rules("`")[1].not_filetypes = lisps
