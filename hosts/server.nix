{
  imports = [./common];

  home-manager.users.tjanas = import ../home/tjanas/server.nix;
  services.logind.lidSwitch = "ignore";
}
