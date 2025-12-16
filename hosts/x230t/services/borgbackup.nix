{ config
, pkgs
, ...
}:
let
  common-config = {
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.sops.secrets.borgbackup-passphrase.path}";
    };
    environment.BORG_RSH = "ssh -F ${config.sops.secrets.borgbackup-config.path} -i ${config.sops.secrets.borgbackup-key.path}";
    compression = "auto,lzma";
    doInit = false;
    preHook = with pkgs; ''
      for i in /mnt/snapshots/*; do
        ${util-linux}/bin/mountpoint -q $i && ${util-linux}/bin/umount $i
      done
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/hp-system/data.* | sort -r | head -1) /mnt/snapshots/hp-data
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/hp-system/home.* | sort -r | head -1) /mnt/snapshots/hp-home
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/hp-system/persist.* | sort -r | head -1) /mnt/snapshots/hp-persist
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_data/backup/local-data/data.* | sort -r | head -1) /mnt/snapshots/x230t-data
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_system/backup/local-system/home.* | sort -r | head -1) /mnt/snapshots/x230t-home
      ${util-linux}/bin/mount -B $(ls -1d /mnt/btrfs_system/backup/local-system/persist.* | sort -r | head -1) /mnt/snapshots/x230t-persist
    '';
    prune.keep = {
      within = "2d";
      daily = 14;
      weekly = 8;
      monthly = 6;
      yearly = 1;
    };
  };
in
{
  services.borgbackup.jobs = {
    "home-backup" =
      common-config
      // {
        repo = "local-backup:home-backup.borg";
        startAt = [ ];
        paths = [
          "/mnt/snapshots/hp-home"
          "/mnt/snapshots/x230t-home"
        ];
        exclude = [
          "**/.cache"
          "**/.local/share/containers"
          "**/.local/share/docker"
          "**/.local/share/Steam"
          "**/.npm"
        ];
      };
    "usb-backup" =
      common-config
      // {
        repo = "local-backup:usb-backup.borg";
        startAt = [ ];
        paths = [
          "/mnt/snapshots/hp-data/archiwum"
          "/mnt/snapshots/hp-data/Documents"
          "/mnt/snapshots/hp-persist"
          "/mnt/snapshots/x230t-data/shares"
          "/mnt/snapshots/x230t-persist"
        ];
        exclude = [
          "**/var/lib/containers"
          "**/var/lib/docker"
          "**/var/lib/libvirt"
          "**/var/lib/incus"
          "**/var/lib/systemd"
        ];
      };
    "remote-backup" =
      common-config
      // {
        repo = "remote-backup:repo";
        startAt = "16:30";
        paths = [
          "/mnt/snapshots/hp-data/archiwum"
          "/mnt/snapshots/hp-data/Documents"
          "/mnt/snapshots/hp-persist"
          "/mnt/snapshots/x230t-data/shares"
          "/mnt/snapshots/x230t-persist"
        ];
        exclude = [
          "**/var/lib/containers"
          "**/var/lib/docker"
          "**/var/lib/libvirt"
          "**/var/lib/incus"
          "**/var/lib/systemd"
        ];
      };
  };

  fileSystems."/mnt/snapshots" = {
    device = "/mnt/btrfs_data/backup/latest";
    options = [ "bind" ];
  };

  environment.persistence."/persist".directories = [ "/root/.cache/borg" "/root/.config/borg" ];

  sops.secrets = {
    borgbackup-config = { };
    borgbackup-key = { };
    borgbackup-passphrase = { };
  };
}
