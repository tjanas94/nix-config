{config, pkgs, ...}: let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  lockscreen = pkgs.writeShellScript "lockscreen" ''
    if [ -z "$(lsusb | grep Yubico)" ]; then
      loginctl list-sessions --no-legend | cut -d' ' -f1 | xargs -n1 loginctl lock-session
    fi
  '';
in {
  users = {
    mutableUsers = false;
    users.tjanas = {
      isNormalUser = true;
      description = "Tomasz Janas";
      extraGroups =
        ["wheel"]
        ++ ifTheyExist [
          "audio"
          "dialout"
          "docker"
          "libvirtd"
          "lp"
          "networkmanager"
          "scanner"
          "video"
          "wireshark"
        ];
      passwordFile = "/persist/password_file";
      openssh = import ./authorized-keys.nix;
    };
  };

  home-manager.users.tjanas = import ../../../home/tjanas;
  security = {
    sudo.extraConfig = ''Defaults lecture="never"'';
    pam = {
      u2f.enable = true;
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
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

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjanas";
  };
}
