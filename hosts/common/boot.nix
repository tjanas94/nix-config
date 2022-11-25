{ lib, pkgs, ... }: {
  boot = {
    loader.grub = {
      enable = true;
      enableCryptodisk = true;
    };

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
      "net.ipv4.ip_unprivileged_port_start" = 0;
    };

    initrd = {
      postDeviceCommands = lib.mkBefore ''
        mkdir -p /mnt
        mount -o subvol=/ /dev/disk/by-label/nixos-system /mnt

        btrfs subvolume list -o /mnt/root |
        cut -f9 -d' ' |
        while read subvolume; do
          echo "deleting /$subvolume subvolume..."
          btrfs subvolume delete "/mnt/$subvolume"
        done &&
        echo "deleting /root subvolume..." &&
        btrfs subvolume delete /mnt/root

        echo "restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        umount /mnt
      '';

      secrets = { "/persist/crypto_keyfile.bin" = null; };

      luks.devices."luks-root" = {
        device = "/dev/disk/by-partlabel/root";
        keyFile = "/persist/crypto_keyfile.bin";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=boot" "compress=zstd" "noatime" ];
    };

    "/home" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

    "/nix" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

    "/persist" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/var/log" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

    "/swap" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };
  };

  swapFile = {
    enable = lib.mkDefault true;
    path = "/swap/swapfile";
    size = lib.mkDefault (8 * 1024);
  };

  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };
}
