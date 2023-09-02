{
  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  environment.persistence."/persist".directories = [ "/etc/NetworkManager/system-connections" "/var/lib/NetworkManager" ];
}
