{
  services.unbound = {
    enable = true;
    resolveLocalQueries = false;
    settings.server = {
      access-control = [ "0.0.0.0/0 allow" "::/0 allow" ];
      interface = [ "0.0.0.0" "::" ];
      port = 5335;
    };
  };

  networking.firewall.allowedUDPPorts = [ 5335 ];
  environment.persistence."/persist".directories = [ "/var/lib/unbound" ];
}
