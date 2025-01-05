{ lib
, inputs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.dell-latitude-5520
    ./hardware-configuration.nix
    ../workstation.nix
  ];

  services.btrbk.instances.system.settings.snapshot_preserve = lib.mkForce "no";

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "dell";
  system.stateVersion = "24.11";
}
