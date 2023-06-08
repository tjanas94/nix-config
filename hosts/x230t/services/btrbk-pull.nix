{config, ...}: {
  services.btrbk.instances.lenovo = {
    onCalendar = "hourly";
    settings = {
      snapshot_create = "no";
      snapshot_preserve_min = "all";
      ssh_identity = config.sops.secrets.btrbk-key.path;
      ssh_user = "btrbk";
      stream_compress = "lz4";
      target_preserve_min = "no";
      target_preserve = "14d 8w 6m 1y";
      timestamp_format = "long";

      volume = {
        "ssh://lenovo.janas.dev/mnt/btrfs_data" = {
          target = "/mnt/btrfs_data/backup/lenovo-data";
          snapshot_dir = "backup/local-data";
          subvolume = "data";
        };
        "ssh://lenovo.janas.dev/mnt/btrfs_system" = {
          target = "/mnt/btrfs_data/backup/lenovo-system";
          snapshot_dir = "backup/local-system";
          subvolume = {
            "home" = {};
            "persist" = {};
          };
        };
      };
    };
  };

  sops.secrets.btrbk-key.owner = config.users.users.btrbk.name;
}
