{ lib, ... }: {
  programs.zathura.enable = true;
  xdg.configFile."zathura/zathurarc".source =
    lib.mkForce ../../../../config/zathura/zathurarc;
}
