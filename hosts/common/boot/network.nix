{config, ...}: {
  boot.initrd.network = {
    enable = true;
    udhcpc.extraArgs = ["--timeout 5 --tryagain 20 --background"];

    ssh = {
      enable = true;
      port = 2222;
      authorizedKeys = import ../users/tjanas/authorized-keys.nix;
      hostKeys = [config.sops.secrets.initrd-host-key.path];
    };
  };

  sops.secrets.initrd-host-key = {};
}
