{config, ...}: let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
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
  security.sudo.extraConfig = ''Defaults lecture="never"'';

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjanas";
  };
}
