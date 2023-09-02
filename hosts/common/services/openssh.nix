{
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
        path = "/persist/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  security.pam.enableSSHAgentAuth = true;

  users.users.root.openssh.authorizedKeys.keys = import ../users/tjanas/authorized-keys.nix;
}
