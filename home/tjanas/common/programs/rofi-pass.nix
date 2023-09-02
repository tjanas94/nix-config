{ lib, ... }: {
  programs.rofi.pass.enable = true;
  xdg.configFile."rofi-pass/config".source =
    lib.mkForce ../../../../config/rofi-pass/config;
}
