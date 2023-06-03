{
  services = {
    nginx.virtualHosts."git.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
      locations."/".proxyPass = "http://localhost:3000/";
    };

    postgresql = {
      authentication = ''
        local gitea all ident map=gitea-users
      '';
      identMap = ''
        gitea-users gitea gitea
      '';
    };

    gitea = {
      enable = true;
      database.type = "postgres";
      settings = {
        server = {
          DOMAIN = "git.janas.dev";
          ROOT_URL = "https://git.janas.dev/";
        };
        session.COOKIE_SECURE = true;
      };
    };
  };

  environment.persistence."/persist".directories = ["/var/lib/gitea"];
}
