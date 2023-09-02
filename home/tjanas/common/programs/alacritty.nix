{ lib, ... }: {
  programs.alacritty.enable = true;
  xdg.configFile."alacritty/alacritty.yml".source =
    lib.mkForce ../../../../config/alacritty/alacritty.yml;

  home.sessionVariables.TERMINAL = "alacritty";
}
