{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x230
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ../common
  ];

  sops.defaultSopsFile = ./secrets.yaml;
  boot.loader.grub.devices = ["/dev/sda"];
  networking.hostName = "x230t";
  services.xserver.wacom.enable = true;
  swapFile.size = 4 * 1024;
  system.stateVersion = "22.11";
}
