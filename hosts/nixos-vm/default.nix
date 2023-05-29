{
  imports = [./hardware-configuration.nix ../workstation.nix];

  boot.loader.grub.devices = ["/dev/vda"];
  swapFile.size = 2 * 1024;

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "nixos-vm";
  system.stateVersion = "22.11";
}
