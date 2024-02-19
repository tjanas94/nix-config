{ lib, ... }: {
  programs.alacritty.enable = true;
  xdg.configFile."alacritty/alacritty.toml".source =
    lib.mkForce ../../../../config/alacritty/alacritty.toml;

  home.sessionVariables.TERMINAL = "alacritty";
}
