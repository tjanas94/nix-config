{ pkgs, ... }: {
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
      let g:tsserver_path = '${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js'
      lua require('core')
    '';

    plugins = with pkgs.vimPlugins; [
      cmp_luasnip
      cmp-buffer
      cmp-path
      cmp-nvim-lsp
      cmp-nvim-lua
      comment-nvim
      friendly-snippets
      gitsigns-nvim
      gruvbox-nvim
      harpoon
      lsp-zero-nvim
      lualine-nvim
      luasnip
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      telescope-fzf-native-nvim
      telescope-nvim
      trouble-nvim
      undotree
      vim-abolish
      vim-be-good
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
