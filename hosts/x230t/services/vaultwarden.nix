{
  services = {
    nginx.virtualHosts."vaultwarden.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
      locations."/".proxyPass = "http://localhost:8000/";
    };

    postgresql = {
      authentication = ''
        local vaultwarden all ident map=vaultwarden-users
      '';
      identMap = ''
        vaultwarden-users vaultwarden vaultwarden
      '';

      ensureDatabases = [ "vaultwarden" ];
      ensureUsers = [
        {
          name = "vaultwarden";
          ensureDBOwnership = true;
        }
      ];
    };

    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        DOMAIN = "https://vaultwarden.janas.dev";
        DATABASE_URL = "postgres:///vaultwarden?host=/run/postgresql";
      };
    };
  };

  environment.persistence."/persist".directories = [ "/var/lib/bitwarden_rs" ];
}
