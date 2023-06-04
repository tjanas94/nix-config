{
  imports = [./common];

  home-manager.users.tjanas = import ../home/tjanas/server.nix;
  services.fail2ban.enable = true;
  services.logind.lidSwitch = "ignore";
}
