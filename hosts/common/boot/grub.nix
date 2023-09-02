{ config, ... }: {
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    devices = [ "nodev" ];
    users.root.hashedPasswordFile = config.sops.secrets.grub-password.path;
  };

  sops.secrets.grub-password.sopsFile = ../secrets.yaml;
}
