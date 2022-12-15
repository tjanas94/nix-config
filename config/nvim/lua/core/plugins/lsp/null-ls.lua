local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    sources = {
        formatting.alejandra,
        formatting.fixjson,
        formatting.prettierd,
        formatting.shfmt,
        diagnostics.statix,
        code_actions.gitsigns,
        code_actions.gitrebase,
        code_actions.statix,
    },
})
