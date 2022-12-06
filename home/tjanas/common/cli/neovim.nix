{ pkgs, inputs, ... }:
with pkgs.vimPlugins;
let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  filetype-nvim = buildVimPluginFrom2Nix {
    pname = "filetype.nvim";
    version = "master";
    src = inputs.filetype-nvim;
  };
  polyword-vim = buildVimPluginFrom2Nix {
    pname = "polyword.vim";
    version = "master";
    src = inputs.polyword-vim;
  };
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraConfig = ''
      lua require('core')
    '';

    plugins = [
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      comment-nvim
      filetype-nvim
      gitsigns-nvim
      gruvbox-community
      gv-vim
      impatient-nvim
      lualine-nvim
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
        customNodePackages.stylelint-lsp
        nodePackages."@tailwindcss/language-server"
        bash-language-server
        dockerfile-language-server-nodejs
        golangci-lint
        golangci-lint-langserver
        gopls
        sumneko-lua-language-server
        typescript
        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ];

    sessionVariables.EDITOR = "nvim";
  };
}
