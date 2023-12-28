{ config, inputs, lib, pkgs, ... }: {
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      animations.enabled = false;
      general = {
        gaps_in = 0;
        gaps_out = 0;
        layout = "master";
      };
      input.kb_layout = "pl";
      misc = {
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
      };

      bind =
        let
          browser = "brave";
          emacs = "emacsclient -a emacs -c";
          menu = "wofi";
          terminal = config.home.sessionVariables.TERMINAL;

          workspaces = [
            "0"
            "1"
            "2"
            "3"
            "4"
            "5"
            "6"
            "7"
            "8"
            "9"
          ];

          directions = rec {
            left = "l";
            right = "r";
            up = "u";
            down = "d";
            h = left;
            l = right;
            k = up;
            j = down;
          };
        in
        [
          "SUPERSHIFT, c, killactive,"
          "SUPERSHIFT, q, exit,"

          "SUPER, f, fullscreen, 1"
          "SUPERSHIFT, f, fullscreen, 0"
          "SUPERSHIFT, v, togglefloating,"
          "SUPERSHIFT, s, togglesplit,"

          "SUPER, minus, splitratio, -0.25"
          "SUPERSHIFT, minus, splitratio, -0.3333333"

          "SUPER, equal, splitratio, 0.25"
          "SUPERSHIFT, equal, splitratio, 0.3333333"

          "SUPER, g, togglegroup"
          "SUPER, t, lockactivegroup, toggle"
          "SUPER, apostrophe, changegroupactive, f"
          "SUPERSHIFT, apostrophe, changegroupactive, b"

          "SUPER, return, exec, ${terminal}"
          "SUPERSHIFT, return, exec, ${terminal} -e switch-project"
          "SUPER, space, exec, ${menu} -S 'drun,run'"

          "SUPERALT, b, exec, ${browser}"
          "SUPERALT, e, exec, ${emacs}"
          "SUPERALT, l, exec, swaylock --grace 2"

          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          "SHIFT, XF86AudioMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
          ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"

          ", XF86MonBrightnessUp, exec, light -A 10"
          ", XF86MonBrightnessDown, exec, light -U 10"

          ", XF86AudioPrev, exec, playerctl -p mpv previous"
          ", XF86AudioNext, exec, playerctl -p mpv next"
          ", XF86AudioPlay, exec, playerctl -p mpv play-pause"
          ", XF86AudioPause, exec, playerctl -p mpv play-pause"
          ", code:208, exec, playerctl -p mpv play-pause"
          ", XF86AudioStop, exec, playerctl -a pause"

          ", Print, exec, grimblast --notify freeze copy output"
          "SHIFT, Print, exec, grimblast --notify freeze copy active"
          "CONTROL, Print, exec, grimblast --notify freeze copy screen"
          "SUPER, Print, exec, grimblast --notify freeze copy area"
          "ALT, Print, exec, grimblast --notify freeze copy area"

          "SUPER, z, togglespecialworkspace, scratch"
          "SUPERSHIFT, z, movetoworkspace, special:scratch"

          "SUPER, period, workspace, e+1"
          "SUPER, comma, workspace, e-1"
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"
        ] ++
        (map
          (n:
            "SUPER,${n},workspace,name:${n}"
          )
          workspaces) ++
        (map
          (n:
            "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}"
          )
          workspaces) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPER,${key},movefocus,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERSHIFT,${key},swapwindow,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERCONTROL,${key},movewindoworgroup,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERALT,${key},focusmonitor,${direction}"
          )
          directions) ++
        (lib.mapAttrsToList
          (key: direction:
            "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
          )
          directions);

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      exec = with pkgs; let
        find = "${findutils}/bin/find";
        shuf = "${coreutils}/bin/shuf";
      in
      [
        "${swaybg}/bin/swaybg -i $(${find} ${inputs.wallpapers.outPath} -name '*.jpg' | ${shuf} -n1) --mode fill"
      ];

      monitor = [
        ", preferred, auto, 1"
        "DP-3, 3440x1440@50, auto, 1"
        "DP-5, preferred, auto, 1, transform, 3"
      ];
    };

    extraConfig = ''
      # Passthrough mode (e.g. for VNC)
      bind=SUPER, p, submap, passthrough
      submap=passthrough
      bind=SUPER, p, submap, reset
      submap=reset
    '';
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
    };
  };
}
