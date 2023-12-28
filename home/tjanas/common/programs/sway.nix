{ config, inputs, pkgs, ... }: {
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };

  wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    config = {
      modifier = "Mod4";
      menu = "wofi -S drun,run";
      terminal = config.home.sessionVariables.TERMINAL;
      startup = with pkgs; let
        find = "${findutils}/bin/find";
        shuf = "${coreutils}/bin/shuf";
      in
      [{
        always = true;
        command = "${swaybg}/bin/swaybg -i $(${find} ${inputs.wallpapers.outPath} -name '*.jpg' | ${shuf} -n1) --mode fill";
      }];
    };
  };

  home = {
    packages = with pkgs; [
      grimblast
      swaybg
      swaylock
      wdisplays
      wl-clipboard
      wofi
    ];

    sessionVariables = {
      LIBSEAT_BACKEND = "logind";
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";

    };
  };
}

