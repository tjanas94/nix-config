{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x230
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ../server.nix
    ./services
  ];

  boot.loader.grub.devices = ["/dev/sda"];
  services.xserver.wacom.enable = true;
  swapFile.size = 4 * 1024;

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "x230t";
  system.stateVersion = "22.11";
}
