local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    sources = {
        formatting.fixjson,
        formatting.prettierd,
        formatting.shfmt,
        code_actions.gitsigns,
        code_actions.gitrebase,
    },
})
