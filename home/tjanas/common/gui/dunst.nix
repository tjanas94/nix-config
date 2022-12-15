{lib, ...}: {
  services.dunst.enable = true;
  xdg.configFile."dunst/dunstrc".source =
    lib.mkForce ../../../../config/dunst/dunstrc;
}
