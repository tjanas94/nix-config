{config, ...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    clientMaxBodySize = "300m";
  };

  networking.firewall.allowedTCPPorts = [80 443];
  users.users.nginx.extraGroups = [config.users.users.acme.group];
}
