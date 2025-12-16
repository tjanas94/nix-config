{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      blink-cmp-copilot
      blink-compat
      cmp-conjure
      comment-nvim
      conjure
      conform-nvim
      copilot-lua
      friendly-snippets
      gitsigns-nvim
      gruvbox-nvim
      harpoon2
      lazydev-nvim
      lualine-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-jdtls
      nvim-paredit
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      oil-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      undotree
      vim-abolish
      vim-be-good
      vim-dispatch
      vim-fugitive
      vim-jack-in
      vim-repeat
      vim-sleuth
      vim-surround
      vim-textobj-entire
      vim-textobj-user
    ];
  };

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "/home/tjanas/workspace/github.com/tjanas94/nix-config/master/config/nvim";
}
