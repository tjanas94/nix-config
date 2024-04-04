{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lz4
  ];
  services.btrbk = {
    instances.system = {
      onCalendar = "hourly";
      settings = {
        snapshot_preserve_min = "2d";
        snapshot_preserve = "14d 8w 6m 1y";
        stream_compress = "lz4";
        timestamp_format = "long";

        volume."/mnt/btrfs_system" = {
          snapshot_dir = "backup/local-system";
          subvolume = {
            "home" = { };
            "persist" = { };
          };
        };
      };
    };

    sshAccess = [
      {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAW3zpj1s03lqIfSo6esWr336We5P7pU2NYgYxkygk+j";
        roles = [ "send" ];
      }
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "btrbk" ];
      commands = [
        { command = "/run/current-system/sw/bin/btrfs"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];
}
