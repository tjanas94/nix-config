{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-acpi_call
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    inputs.hardware.nixosModules.common-pc-laptop-hdd
    ./hardware-configuration.nix
    ../common
    ../common/efi.nix
  ];

  boot.initrd.luks.devices."luks-data" = {
    device = "/dev/disk/by-partlabel/data";
    keyFile = "/persist/crypto_keyfile.bin";
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-label/nixos-data";
    fsType = "btrfs";
    options = ["subvol=data" "compress=zstd"];
  };

  hardware.nvidia.prime = {
    intelBusId = lib.mkDefault "PCI:0:2:0";
    nvidiaBusId = lib.mkDefault "PCI:1:0:0";
  };

  networking.hostName = "lenovo";
  services.xserver.videoDrivers = ["displaylink" "modesetting" "nvidia"];
  system.stateVersion = "22.11";
}
