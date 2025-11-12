{ config, ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "tomek@janas.dev";

    certs."janas.dev" = {
      domain = "*.janas.dev";
      dnsProvider = "cloudflare";
      credentialsFile = config.sops.secrets.acme-dns.path;
    };
  };

  environment.persistence."/persist".directories = [ "/var/lib/acme" ];
  sops.secrets.acme-dns.owner = config.users.users.acme.name;
}
