{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.nixpkgs-unstable-small.postgresql;
  };
  environment.persistence."/persist".directories = [ "/var/lib/postgresql" ];
}
