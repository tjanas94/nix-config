local autopairs = require('nvim-autopairs')
local lisps = { 'clojure', 'fennel', 'lisp', 'scheme' }

autopairs.setup()
autopairs.get_rules("'")[1].not_filetypes = lisps
autopairs.get_rules("`")[1].not_filetypes = lisps
