_: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  environment.persistence."/persist" = {
    directories = ["/etc/NetworkManager/system-connections" "/var/lib/NetworkManager"];
  };
}
