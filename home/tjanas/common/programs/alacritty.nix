{ lib, pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.nixpkgs-stable.alacritty;
  };
  xdg.configFile."alacritty/alacritty.yml".source =
    lib.mkForce ../../../../config/alacritty/alacritty.yml;

  home.sessionVariables.TERMINAL = "alacritty";
}
