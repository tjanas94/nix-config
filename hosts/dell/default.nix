{ config, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.dell-latitude-5520
    ./hardware-configuration.nix
    ../common
    ../common/efi.nix
  ];

  networking.hostName = "dell";
  system.stateVersion = "22.11";
}
