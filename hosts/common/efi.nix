_: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      enableCryptodisk = true;
      efiSupport = true;
      device = "nodev";
    };
  };

  fileSystems = {
    "/boot/efi" = {
      device = "/dev/disk/by-partlabel/esp";
      fsType = "vfat";
      options = ["noatime"];
    };
  };
}
