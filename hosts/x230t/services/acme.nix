{config, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "tomek@janas.dev";

    certs."janas.dev" = {
      domain = "*.janas.dev";
      dnsProvider = "ovh";
      credentialsFile = config.sops.secrets.ovh-dns.path;
    };
  };

  environment.persistence."/persist".directories = ["/var/lib/acme"];
  sops.secrets.ovh-dns.owner = config.users.users.acme.name;
}
