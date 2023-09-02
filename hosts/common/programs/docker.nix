{
  virtualisation = {
    docker.enable = true;

    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.persistence."/persist".directories = [ "/var/lib/docker" ];
}
