{ pkgs, inputs, ... }:
with pkgs.vimPlugins;
let
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
  filetype-nvim = buildVimPluginFrom2Nix {
    pname = "filetype.nvim";
    version = "master";
    src = inputs.filetype-nvim;
  };
  lspsaga-nvim = buildVimPluginFrom2Nix {
    pname = "lspsaga.nvim";
    version = "master";
    src = inputs.lspsaga-nvim;
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
      cmp_luasnip
      cmp-nvim-lsp
      comment-nvim
      filetype-nvim
      friendly-snippets
      gitsigns-nvim
      git-worktree-nvim
      gruvbox-community
      gv-vim
      harpoon
      impatient-nvim
      lspsaga-nvim
      lualine-nvim
      luasnip
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      polyword-vim
      popup-nvim
      quick-scope
      refactoring-nvim
      registers-nvim
      symbols-outline-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      undotree
      vim-abolish
      vim-better-whitespace
      vim-dispatch
      vim-fugitive
      vim-repeat
      vim-sandwich
      vim-sayonara
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
        nodePackages."@tailwindcss/language-server"
        bash-language-server
        dockerfile-language-server-nodejs
        sumneko-lua-language-server
        typescript
        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ];

    sessionVariables.EDITOR = "nvim";
  };
}
