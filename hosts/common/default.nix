{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.impermanence
      inputs.home-manager.nixosModules.home-manager
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
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  environment = {
    persistence."/persist" = {
      hideMounts = true;
      files = ["/etc/machine-id"];
      directories = ["/var/lib/systemd"];
    };
    enableAllTerminfo = true;
  };
}
