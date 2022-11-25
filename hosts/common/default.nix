{ inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModule
    ./boot.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./openssh.nix
    ./printing.nix
    ./programs.nix
    ./users/tjanas.nix
    ./virtualisation.nix
    ./xserver.nix
  ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [ "/etc/machine-id" ];
  };
}
