_: {
  imports = [./hardware-configuration.nix ../common];

  sops.defaultSopsFile = ./secrets.yaml;
  boot.loader.grub.devices = ["/dev/vda"];
  networking.hostName = "nixos-vm";
  swapFile.size = 2 * 1024;
  system.stateVersion = "22.11";
}
