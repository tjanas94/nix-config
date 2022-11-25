{ inputs, lib, ... }: {
  xsession = {
    enable = true;
    windowManager.herbstluftwm.enable = true;
  };

  xdg.configFile = {
    "herbstluftwm/autostart".source =
      lib.mkForce ../../../../config/herbstluftwm/autostart;

    screenlayout = {
      source = ../../../../config/screenlayout;
      recursive = true;
    };

    wallpapers = {
      source = inputs.wallpapers.outPath;
      recursive = true;
    };
  };
}
