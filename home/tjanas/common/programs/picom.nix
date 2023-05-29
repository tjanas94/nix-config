{lib, ...}: {
  services.picom.enable = true;
  xdg.configFile."picom/picom.conf".source =
    lib.mkForce ../../../../config/picom/picom.conf;
}
