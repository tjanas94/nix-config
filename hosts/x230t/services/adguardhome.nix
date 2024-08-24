{
  services = {
    nginx.virtualHosts."adguard.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
      locations."/".proxyPass = "http://localhost:3001/";
    };

    adguardhome = {
      enable = true;
      host = "127.0.0.1";
      port = 3001;
      settings = { };
    };
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
  environment.persistence."/persist".directories = [{
    directory = "/var/lib/private/AdGuardHome";
    mode = "0700";
  }];
}
