{ inputs
, ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    ./hardware-configuration.nix
    ../workstation.nix
    ./services
  ];

  fileSystems."/data" = {
    device = "/dev/disk/by-label/nixos-system";
    fsType = "btrfs";
    options = [ "subvol=data" "compress=zstd" ];
  };

  services.btrbk.instances.system.settings.volume."/mnt/btrfs_system".subvolume."data" = { };

  sops.defaultSopsFile = ./secrets.yaml;
  networking.hostName = "hp";
  system.stateVersion = "25.05";

  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/nvme0n1";
      }
    ];
  };
}
