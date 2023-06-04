{config, ...}: {
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
      passwordFile = config.sops.secrets.photoprism-adminpass.path;
      settings = {
        PHOTOPRISM_ADMIN_USER = "admin";
        PHOTOPRISM_DEFAULT_LOCALE = "en";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "https://photoprism.janas.dev";
        PHOTOPRISM_SITE_TITLE = "My PhotoPrism";
      };
    };
  };

  environment.persistence."/persist".directories = ["/var/lib/private/photoprism"];
  sops.secrets.photoprism-adminpass = {};
}
