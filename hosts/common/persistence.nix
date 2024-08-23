{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  security.sudo.extraConfig = ''Defaults lecture="never"'';

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [ "/etc/machine-id" ];
    directories = [ "/var/lib/nixos" "/var/lib/systemd" ];
  };
}
