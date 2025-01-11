{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
  };
  environment.persistence."/persist".directories = [ "/var/lib/postgresql" ];
}
