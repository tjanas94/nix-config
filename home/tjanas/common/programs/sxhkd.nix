{ lib, ... }:
let
  Mod = "super";
  App = "${Mod} + alt + shift + ctrl";
  Project = "${Mod} + alt";
  Terminal = "alacritty";
in
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "${Mod} + shift + {q,c}" = "herbstclient {quit,close}";
      "${Mod} + shift + r" = "pkill -usr1 -x sxhkd; herbstclient reload";
      "${Mod} + Return" = "systemd-run-app ${Terminal}";
      "${Mod} + space" = "systemd-run-app rofi -modi combi -show combi -combi-modi drun,run";
      "${Mod} + slash" = "systemd-run-app rofi -show window";

      "${Mod} + {_,shift + ,ctrl +}{Left,Down,Up,Right}" = "herbstclient {focus,shift,resize} {left,down,up,right} {_,_,0.05}";
      "${Mod} + {_,shift + ,ctrl +}{h,j,k,l}" = "herbstclient {focus,shift,resize} {left,down,up,right} {_,_,0.05}";

      "${Mod} + {u,o}" = "herbstclient split {bottom,right} 0.5";
      "${Mod} + shift + o" = "herbstclient split right 0.6";
      "${Mod} + ctrl + o" = "herbstclient chain , split left 0.25 , split right 0.6666";
      "${Mod} + ctrl + space" = "herbstclient split explode";

      "${Mod} + {1-9}" = "herbstclient use {1-9}";
      "${Mod} + shift + {1-9}" = "i={1-9}; herbstclient chain , move $i , use $i";

      "${Mod} + {period,comma}" = "herbstclient use_index {+,-}1 --skip-visible";
      "${Mod} + shift + {period,comma}" = "i={+,-}1; herbstclient chain , move_index $i --skip-visible , use_index $i --skip-visible";

      "${Mod} + r" = "herbstclient remove";
      "${Mod} + shift + f" = "herbstclient floating toggle";
      "${Mod} + f" = "herbstclient fullscreen toggle";
      "${Mod} + p" = "herbstclient pseudotile toggle";
      "${Mod} + shift + space" = "herbstclient cycle_layout 1 vertical max";

      "${Mod} + {_, shift + }BackSpace" = "herbstclient cycle_monitor {+,-}1";
      "${Mod} + {_, shift + }Tab" = "herbstclient cycle {+,-}1";
      "${Mod} + c" = "herbstclient cycle_all";
      "${Mod} + i" = "herbstclient jumpto urgent";

      "XF86Audio{Lower,Raise}Volume" = "pactl set-sink-volume @DEFAULT_SINK@ {-,+}5%";
      "XF86AudioMute" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      "shift + XF86AudioMute" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
      "XF86AudioMicMute" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";

      "XF86MonBrightness{Up,Down}" = "light -{A,U} 10";

      "XF86Audio{Prev,Next}" = "playerctl -p mpv {previous,next}";
      "XF86AudioPlay" = "playerctl -p mpv play-pause";
      "208" = "playerctl -p mpv play-pause";
      "XF86AudioPause" = "playerctl -p mpv play-pause";
      "XF86AudioStop" = "playerctl -a pause";

      "Print" = "systemd-run-app scrot -s";
      "shift + Print" = "systemd-run-app scrot -u";

      "${App} + b" = "systemd-run-app brave";
      "${App} + d; h; p" = "bt-toggle-profile E8:EE:CC";
      "${App} + d; h; r" = "bt-reconnect E8:EE:CC";
      "${App} + d; m; r" = "bt-reconnect D5:A3:9B";
      "${App} + d; m; p" = "bt-setup-device D5:A3:9B";
      "${App} + e" = "systemd-run-app emacsclient -a emacs -c";
      "${App} + f" = "systemd-run-app filezilla";
      "${App} + h" = "systemd-run-app ${Terminal} -e btop";
      "${App} + k" = "systemd-run-app keepassxc";
      "${App} + l" = "systemd-run-app i3lock -nc000000";
      "${App} + o" = "systemd-run-app openfm";
      "${App} + p" = "systemd-run-app rofi-pass";
      "${App} + s" = "systemd-run-app pavucontrol";
      "${App} + t" = "systemd-run-app thunar";
      "${App} + y" = "systemd-run-app yt-player";

      "${Project} + space" = "systemd-run-app ${Terminal} -e switch-project";
      "${Project} + s" = "herbstclient use_previous";
      "${Project} + {n,e,i,o}" = "systemd-run-app ${Terminal} -e switch-pinned-project {1,2,3,4}";
    };
  };
}
