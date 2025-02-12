require('conform').setup({
    formatters_by_ft = {
        astro = { 'prettierd' },
        graphql = { 'prettierd' },
        java = { 'google-java-format' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        nix = { 'nixpkgs_fmt' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        sh = { 'shfmt' },
    },
    formatters = {
        ['google-java-format'] = {
            prepend_args = { '-a' },
        },
        shfmt = {
            prepend_args = { '-i', '4' },
        },
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    vim.opt_local.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
})
