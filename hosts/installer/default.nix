{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
  ];

  nix = {
    daemonCPUSchedPolicy = "idle";
    settings.experimental-features = "nix-command flakes";
  };

  users.users = {
    root.openssh = import ../common/users/authorized-keys.nix;
    nixos.openssh = import ../common/users/authorized-keys.nix;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
