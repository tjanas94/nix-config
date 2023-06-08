{
  services.btrbk.instances.data = {
    onCalendar = "hourly";
    settings = {
      snapshot_preserve_min = "2d";
      snapshot_preserve = "14d 8w 6m 1y";
      target_preserve_min = "no";
      target_preserve = "14d 8w 6m 1y";
      timestamp_format = "long";

      volume = {
        "/mnt/btrfs_data" = {
          snapshot_dir = "backup/local-data";
          subvolume = "data";
        };
        "/mnt/btrfs_system" = {
          target = "/mnt/btrfs_data/backup/local-system";
          snapshot_create = "no";
          snapshot_dir = "backup/local-system";
          snapshot_preserve_min = "all";
          subvolume = {
            "home" = {};
            "persist" = {};
          };
        };
      };
    };
  };
}
