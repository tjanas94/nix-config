{
  imports = [ ./common ];

  home-manager.users.tjanas = import ../home/tjanas/server.nix;
  services.btrfs.autoScrub.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
}
