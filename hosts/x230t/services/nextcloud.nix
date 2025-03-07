{ config
, pkgs
, ...
}: {
  services = {
    nginx.virtualHosts."nextcloud.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
    };

    postgresql = {
      authentication = ''
        local nextcloud all ident map=nextcloud-users
      '';
      identMap = ''
        nextcloud-users nextcloud nextcloud
      '';
    };

    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "nextcloud.janas.dev";
      https = true;
      database.createLocally = true;
      configureRedis = true;
      config = {
        adminpassFile = config.sops.secrets.nextcloud-adminpass.path;
        dbtype = "pgsql";
      };
      settings = {
        default_phone_region = "PL";
        maintenance_window_start = "1";
      };
      phpOptions."opcache.interned_strings_buffer" = "16";
      phpExtraExtensions = all: [
        (all.smbclient.overrideAttrs (_: {
          name = "php-smbclient-1.1.1";
          src = pkgs.fetchurl {
            url = "https://pecl.php.net/get/smbclient-1.1.1.tgz";
            sha256 = "sha256-hFINXHP4t8n1kDccUQzPHw13QFz5p2cmaHNZ5t+elrI=";
          };
        }))
      ];
    };
  };

  environment.persistence."/persist".directories = [ "/var/lib/nextcloud" ];
  sops.secrets.nextcloud-adminpass.owner = config.users.users.nextcloud.name;
}
