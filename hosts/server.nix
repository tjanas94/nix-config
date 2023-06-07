{
  imports = [./common];

  home-manager.users.tjanas = import ../home/tjanas/server.nix;
  services.btrfs.autoScrub.enable = true;
  services.fail2ban.enable = true;
  services.logind.lidSwitch = "ignore";
}
