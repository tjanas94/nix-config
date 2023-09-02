{ pkgs, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings.mysqld.bind-address = "127.0.0.1";
  };

  environment.persistence."/persist".directories = [ "/var/lib/mysql" ];
}
