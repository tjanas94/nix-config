{ pkgs, ... }: {
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.xbindkeys}/bin/xbindkeys
    '';
  };

  xresources.properties."Xft.dpi" = 108;

  home.packages = with pkgs; [
    arandr
    feh
    scrot
    xsel
  ];

  services = {
    picom.enable = true;
    unclutter.enable = true;
  };
}
