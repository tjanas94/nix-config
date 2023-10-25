{ config, pkgs, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users = {
    mutableUsers = false;
    users.tjanas = {
      isNormalUser = true;
      description = "Tomasz Janas";
      extraGroups =
        [ "wheel" ]
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
      hashedPasswordFile = config.sops.secrets.tjanas-password.path;
      openssh.authorizedKeys.keys = import ./authorized-keys.nix;
      shell = pkgs.zsh;
    };
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "tjanas";
  };

  sops.secrets.tjanas-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };
}
