{
  config,
  pkgs,
  ...
}: let
  common-config = {
    paths = [
      "/mnt/snapshots/lenovo-data/archiwum"
      "/mnt/snapshots/lenovo-data/Documents"
      "/mnt/snapshots/lenovo-persist"
      "/mnt/snapshots/x230t-data/shares"
      "/mnt/snapshots/x230t-persist"
    ];
    exclude = [
      "**/var/lib/docker"
      "**/var/lib/libvirt"
      "**/var/lib/systemd"
    ];
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.sops.secrets.borgbackup-passphrase.path}";
    };
    environment.BORG_RSH = "ssh -F ${config.sops.secrets.borgbackup-config.path} -i ${config.sops.secrets.borgbackup-key.path}";
    compression = "auto,lzma";
    doInit = false;
    preHook = with pkgs; ''
      for i in /mnt/snapshots/*; do
        ${utillinux}/bin/mountpoint -q $i && ${utillinux}/bin/umount $i
      done
      ${utillinux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/lenovo-data/data.* | sort -r | head -1) /mnt/snapshots/lenovo-data
      ${utillinux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/lenovo-system/persist.* | sort -r | head -1) /mnt/snapshots/lenovo-persist
      ${utillinux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/local-data/data.* | sort -r | head -1) /mnt/snapshots/x230t-data
      ${utillinux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/local-system/persist.* | sort -r | head -1) /mnt/snapshots/x230t-persist
    '';
    prune.keep = {
      within = "2d";
      daily = 14;
      weekly = 8;
      monthly = 6;
      yearly = 1;
    };
  };
in {
  services.borgbackup.jobs = {
    "usb-backup" =
      common-config
      // {
        repo = "local-backup:usb-backup.borg";
        startAt = [];
      };
    "remote-backup" =
      common-config
      // {
        repo = "remote-backup:repo";
        startAt = "16:00";
      };
  };

  fileSystems."/mnt/snapshots" = {
    device = "/mnt/btrfs_data/backup/latest";
    options = ["bind"];
  };

  environment.persistence."/persist".directories = ["/root/.cache/borg" "/root/.config/borg"];

  sops.secrets = {
    borgbackup-config = {};
    borgbackup-key = {};
    borgbackup-passphrase = {};
  };
}
