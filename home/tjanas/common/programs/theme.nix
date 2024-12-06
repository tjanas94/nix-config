{ inputs
, pkgs
, ...
}:
{
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    iconTheme.name = "Numix";
    theme.name = "gruvbox-dark";
  };

  home.packages = with pkgs; [
    nerd-fonts.hasklug
    gruvbox-dark-gtk
    numix-icon-theme
  ];

  xdg.configFile.wallpapers = {
    source = inputs.wallpapers.outPath;
    recursive = true;
  };
}
