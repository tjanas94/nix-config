{ lib, ... }: {
  xsession.windowManager.herbstluftwm.enable = true;
  xdg.configFile.herbstluftwm = {
    source = lib.mkForce ../../../../config/herbstluftwm;
    recursive = true;
  };
}
