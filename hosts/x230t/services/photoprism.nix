{
  services = {
    nginx.virtualHosts."photoprism.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
      locations."/" = {
        proxyPass = "http://localhost:2342/";
        proxyWebsockets = true;
      };
    };

    mysql = {
      ensureDatabases = ["photoprism"];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };

    photoprism = {
      enable = true;
      originalsPath = "/var/lib/private/photoprism/originals";
      settings = {
        PHOTOPRISM_AUTH_MODE = "public";
        PHOTOPRISM_DEFAULT_LOCALE = "pl";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "https://photoprism.janas.dev";
      };
    };
  };

  fileSystems."/var/lib/private/photoprism/originals" = {
    device = "/data/shares/public";
    options = ["bind"];
  };

  environment.persistence."/persist".directories = ["/var/lib/private/photoprism"];
}
