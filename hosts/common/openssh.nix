{inputs, ...}: let
  hostKey = "/persist/etc/ssh/ssh_host_ed25519_key";
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
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
  security.pam.enableSSHAgentAuth = true;
  sops.age.sshKeyPaths = [hostKey];

  users.users.root.openssh = import ./users/authorized-keys.nix;
}
