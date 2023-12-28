{ pkgs, ... }: {
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.xbindkeys}/bin/xbindkeys
    '';
  };

  xresources.properties."Xft.dpi" = 108;

  home.file.".xbindkeysrc".text = ''
    "${pkgs.xdotool}/bin/xdotool key XF86AudioPlay"
      c:208
  '';

  home.packages = with pkgs; [
    arandr
    feh
    scrot
    xsel
  ];

  services = {
    picom.enable = true;
    unclutter.enable = true;

    xcape = {
      enable = true;
      mapExpression = { Caps_Lock = "Escape"; };
    };
  };
}
