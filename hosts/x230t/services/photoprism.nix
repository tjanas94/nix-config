{ config, ... }: {
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
      ensureDatabases = [ "photoprism" ];
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

  systemd = {
    timers."photoprism-index" = {
      wantedBy = [ "timers.target" ];
      timerConfig.OnCalendar = "hourly";
    };

    services."photoprism-index" = {
      script = ''
        ${config.services.photoprism.package}/bin/photoprism index --cleanup
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "photoprism";
        Group = "photoprism";
        DynamicUser = true;
        StateDirectory = "photoprism";
        WorkingDirectory = "/var/lib/photoprism";
        RuntimeDirectory = "photoprism";

        CapabilityBoundingSet = "";
        LockPersonality = true;
        PrivateDevices = true;
        PrivateUsers = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "@system-service" "~@privileged @setuid @keyring" ];
        UMask = "0066";
      };
      environment = config.systemd.services.photoprism.environment;
    };
  };

  fileSystems."/var/lib/private/photoprism/originals" = {
    device = "/data/shares/public";
    options = [ "bind" ];
  };

  environment.persistence."/persist".directories = [{
    directory = "/var/lib/private/photoprism";
    mode = "0700";
  }];
}
