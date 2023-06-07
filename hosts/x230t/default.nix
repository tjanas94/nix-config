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

  boot.initrd.luks.devices."luks-usb-data" = {
    device = "/dev/disk/by-partlabel/usb-data";

    gpgCard = {
      encryptedPass = ../../config/gnupg/cryptkey.gpg;
      publicKey = ../../config/gnupg/public.asc;
    };
  };

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-label/nixos-usb-data";
      fsType = "btrfs";
      options = ["subvol=data" "compress=zstd"];
    };

    "/mnt/btrfs_data" = {
      device = "/dev/disk/by-label/nixos-usb-data";
      fsType = "btrfs";
      options = ["subvolid=5" "noatime"];
    };
  };

  boot.loader.grub.devices = ["/dev/sda"];
  services.xserver.wacom.enable = true;
  swapFile.size = 4 * 1024;

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "x230t";
  system.stateVersion = "22.11";
}
