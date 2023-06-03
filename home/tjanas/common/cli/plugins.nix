{inputs, ...}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs = {
    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    fzf = {
      enable = true;
      defaultCommand = "fd -t f";
      changeDirWidgetCommand = "fd -t d";
    };
    info.enable = true;
    less.enable = true;
    mcfly = {
      enable = true;
      fuzzySearchFactor = 2;
    };
  };
}