{ inputs
, pkgs
, ...
}: {
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.xbindkeys}/bin/xbindkeys
    '';
  };

  xresources.properties."Xft.dpi" = 108;

  xdg.configFile.wallpapers = {
    source = inputs.wallpapers.outPath;
    recursive = true;
  };

  home.file.".xbindkeysrc".text = ''
    "${pkgs.xdotool}/bin/xdotool key XF86AudioPlay"
      c:208
  '';
}
