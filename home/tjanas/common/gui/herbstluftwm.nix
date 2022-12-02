{ inputs, lib, ... }: {
  xsession = {
    enable = true;
    windowManager.herbstluftwm.enable = true;
    initExtra = ''
      PRIMARY=$(xrandr --listactivemonitors | grep -P '\b3440/\d+?x1440/' | awk '$0=$NF')

      if [ -n "$PRIMARY" ]; then
          xrandr --output "$PRIMARY" --primary
          go run ~/.local/bin/xrandr-split-screen.go 5
      fi
    '';
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
