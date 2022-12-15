{
  lib,
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    script = "polybar main &";
  };

  xdg.configFile."polybar/config.ini".source =
    lib.mkForce ../../../../config/polybar/config.ini;
}
