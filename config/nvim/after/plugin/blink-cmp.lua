local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('blink.cmp').get_lsp_capabilities()
)

require('copilot').setup()
require('blink.cmp').setup({
    keymap = {
      ['<Up>'] = {},
      ['<Down>'] = {},
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'conjure' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
          conjure = {
            name = 'conjure',
            module = 'blink.compat.source',
          },
        },
    },
})
