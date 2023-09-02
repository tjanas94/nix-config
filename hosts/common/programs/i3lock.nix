{ pkgs, ... }:
let
  lockscreen = pkgs.writeShellScript "lockscreen" ''
    if [ -z "$(lsusb | grep Yubico)" ]; then
      loginctl list-sessions --no-legend | cut -d' ' -f1 | xargs -n1 loginctl lock-session
    fi
  '';
in
{
  programs = {
    i3lock.enable = true;

    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock -nc000000";
    };
  };

  services.udev = {
    path = with pkgs; [
      findutils
      usbutils
    ];
    extraRules = ''
      ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="1050/406/*", RUN+="${lockscreen}"
    '';
  };
}
