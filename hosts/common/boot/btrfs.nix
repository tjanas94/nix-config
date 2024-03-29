{ config
, lib
, ...
}: {
  boot.initrd.postDeviceCommands = lib.mkBefore ''
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

    rm -r /run/secrets
  '';

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "noatime" ];
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

    "/mnt/btrfs_system" = {
      device = "/dev/disk/by-label/nixos-system";
      fsType = "btrfs";
      options = [ "subvolid=5" "noatime" ];
    };
  };
}
