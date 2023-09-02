{ inputs
, pkgs
, ...
}: {
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.srandrd}/bin/srandrd autorandr -c
    '';
  };

  xresources.properties."Xft.dpi" = 108;

  xdg.configFile.wallpapers = {
    source = inputs.wallpapers.outPath;
    recursive = true;
  };
}
