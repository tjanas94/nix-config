{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  security.sudo.extraConfig = ''Defaults lecture="never"'';

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [ "/etc/machine-id" ];
    directories = [ "/var/lib/nixos" "/var/lib/systemd" ];
  };
}
