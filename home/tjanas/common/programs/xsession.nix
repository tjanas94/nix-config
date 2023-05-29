{inputs, ...}: {
  xsession = {
    enable = true;
    initExtra = ''
      PRIMARY=$(xrandr --listactivemonitors | grep -P '\b3440/\d+?x1440/' | awk '$0=$NF')

      if [ -n "$PRIMARY" ]; then
          xrandr --output "$PRIMARY" --primary
          go run ~/.local/bin/xrandr-split-screen.go 1 2
      fi
    '';
  };

  xresources.properties."Xft.dpi" = 108;

  xdg.configFile = {
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
