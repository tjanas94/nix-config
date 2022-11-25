{ pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../common/locale.nix
    ../common/nix.nix
    ../common/programs.nix
  ];

  users.users.root.openssh = import ../common/users/authorized-keys.nix;
  users.users.nixos.openssh = import ../common/users/authorized-keys.nix;
  nixpkgs.hostPlatform = "x86_64-linux";
}
