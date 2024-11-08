{ config, pkgs, ... }:
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

    plugins = with pkgs.vimPlugins; [
      cmp_luasnip
      cmp-buffer
      cmp-conjure
      cmp-path
      cmp-nvim-lsp
      cmp-nvim-lua
      comment-nvim
      conjure
      conform-nvim
      copilot-vim
      friendly-snippets
      gitsigns-nvim
      gruvbox-nvim
      harpoon2
      lsp-zero-nvim
      lualine-nvim
      luasnip
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-jdtls
      nvim-paredit
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
      vim-jack-in
      vim-repeat
      vim-sleuth
      vim-surround
    ];
  };

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "/home/tjanas/workspace/github.com/tjanas94/nix-config/master/config/nvim";
}
