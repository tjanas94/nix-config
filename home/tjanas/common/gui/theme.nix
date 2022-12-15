{pkgs, ...}: let
  hasklig-nerdfont = pkgs.nerdfonts.override {fonts = ["Hasklig"];};
in {
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    iconTheme.name = "Numix";
    theme.name = "gruvbox-dark";
  };

  home.packages = with pkgs; [
    hasklig-nerdfont
    gruvbox-dark-gtk
    numix-icon-theme
  ];
}
