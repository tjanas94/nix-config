{
  config,
  pkgs,
  ...
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
      package = pkgs.nextcloud27;
      hostName = "nextcloud.janas.dev";
      https = true;
      database.createLocally = true;
      configureRedis = true;
      config = {
        adminpassFile = config.sops.secrets.nextcloud-adminpass.path;
        dbtype = "pgsql";
      };
      extraOptions.default_phone_region = "PL";
    };
  };

  environment.persistence."/persist".directories = ["/var/lib/nextcloud"];
  sops.secrets.nextcloud-adminpass.owner = config.users.users.nextcloud.name;
}
