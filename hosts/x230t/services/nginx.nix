{ config, ... }: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    clientMaxBodySize = "1g";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  users.users.nginx.extraGroups = [ config.users.users.acme.group ];
}
