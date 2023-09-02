{ config
, inputs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.dell-latitude-5520
    ./hardware-configuration.nix
    ../workstation.nix
  ];

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "dell";
  system.stateVersion = "22.11";
}
