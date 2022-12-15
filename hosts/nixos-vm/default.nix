{...}: {
  imports = [./hardware-configuration.nix ../common ../common/efi.nix];

  networking.hostName = "nixos-vm";
  swapFile.size = 2 * 1024;
  system.stateVersion = "22.11";
}
