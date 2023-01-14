{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
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
      cmp-buffer
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-path
      comment-nvim
      filetype-nvim
      friendly-snippets
      gitsigns-nvim
      gruvbox-community
      gv-vim
      impatient-nvim
      lualine-nvim
      luasnip
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-web-devicons
      polyword-vim
      popup-nvim
      quick-scope
      telescope-fzy-native-nvim
      telescope-nvim
      trouble-nvim
      undotree
      vim-abolish
      vim-better-whitespace
      vim-dispatch
      vim-fugitive
      vim-repeat
      vim-sandwich
      vim-sleuth
      vim-subversive
    ];
  };

  xdg.configFile.nvim = {
    source = ../../../../config/nvim;
    recursive = true;
  };

  home = {
    packages = with pkgs;
    with pkgs.nodePackages; [
      nodePackages."@fsouza/prettierd"
      nodePackages."@tailwindcss/language-server"
      alejandra
      bash-language-server
      dockerfile-language-server-nodejs
      fixjson
      golangci-lint
      golangci-lint-langserver
      gopls
      shfmt
      statix
      stylelint-lsp
      sumneko-lua-language-server
      typescript
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];

    sessionVariables.EDITOR = "nvim";
  };
}
