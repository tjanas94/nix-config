{inputs, ...}: let
  hostKey = "/persist/etc/ssh/ssh_host_ed25519_key";
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = hostKey;
        type = "ed25519";
      }
    ];
  };

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [22];
  sops.age.sshKeyPaths = [hostKey];
}
