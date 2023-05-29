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
    ../workstation.nix
  ];

  boot.initrd.luks.devices."luks-data" = {
    device = "/dev/disk/by-partlabel/data";

    gpgCard = {
      encryptedPass = ../../config/gnupg/cryptkey.gpg;
      publicKey = ../../config/gnupg/public.asc;
    };
  };

  fileSystems."/data" = {
    device = "/dev/mapper/luks-data";
    fsType = "btrfs";
    options = ["subvol=data" "compress=zstd"];
  };

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.videoDrivers = ["displaylink" "modesetting" "nvidia"];

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "lenovo";
  system.stateVersion = "22.11";
}
