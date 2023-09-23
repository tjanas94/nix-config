{ pkgs
, modulesPath
, ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    settings.experimental-features = "nix-command flakes repl-flake";
  };

  users.users = {
    root.openssh.authorizedKeys.keys = import ../common/users/tjanas/authorized-keys.nix;
    nixos.openssh.authorizedKeys.keys = import ../common/users/tjanas/authorized-keys.nix;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
