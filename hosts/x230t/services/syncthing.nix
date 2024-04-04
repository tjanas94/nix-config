{
  services = {
    nginx.virtualHosts."syncthing.janas.dev" = {
      forceSSL = true;
      useACMEHost = "janas.dev";
      locations."/".proxyPass = "http://localhost:8384/";
    };

    syncthing = {
      enable = true;
      openDefaultPorts = true;
      group = "samba";
      guiAddress = "0.0.0.0:8384";
    };
  };

  systemd.services.syncthing.serviceConfig.UMask = "0002";
  environment.persistence."/persist".directories = [ "/var/lib/syncthing" ];
}
