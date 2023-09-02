{ lib, ... }: {
  xsession.windowManager.herbstluftwm.enable = true;
  xdg.configFile."herbstluftwm/autostart".source =
    lib.mkForce ../../../../config/herbstluftwm/autostart;
}
