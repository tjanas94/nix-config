{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraConfig = ''
      let g:jdtls_path = '${pkgs.jdt-language-server}/bin/jdtls'
      let g:tsserver_path = '${pkgs.typescript}/lib/node_modules/typescript/lib'
      let g:astro_plugin_path = '${pkgs.nodePackages."@astrojs/ts-plugin"}/lib/node_modules/@astrojs/ts-plugin'
      lua require('core')
    '';

    plugins = with pkgs.vimPlugins; [
      cmp_luasnip
      cmp-buffer
      cmp-path
      cmp-nvim-lsp
      cmp-nvim-lua
      comment-nvim
      conform-nvim
      copilot-vim
      friendly-snippets
      gitsigns-nvim
      gruvbox-nvim
      harpoon2
      lsp-zero-nvim
      lualine-nvim
      luasnip
      nvim-cmp
      nvim-lspconfig
      nvim-jdtls
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      telescope-fzf-native-nvim
      telescope-nvim
      undotree
      vim-abolish
      vim-be-good
      vim-dispatch
      vim-fugitive
      vim-repeat
      vim-sleuth
      vim-surround
    ];
  };

  xdg.configFile.nvim = {
    source = ../../../../config/nvim;
    recursive = true;
  };
}
