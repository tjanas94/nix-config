{ lib
, pkgs
, ...
}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    script = ''
      MONITOR=""

      if polybar -m | ${pkgs.gnugrep}/bin/grep -q "eDP-1:"; then
        MONITOR=eDP-1
      fi

      MONITOR=$MONITOR polybar main &
    '';
  };

  xdg.configFile."polybar/config.ini".source =
    lib.mkForce ../../../../config/polybar/config.ini;
}
