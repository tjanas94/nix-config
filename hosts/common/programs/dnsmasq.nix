let
  dnsmasq-dir = "/etc/dnsmasq.d";
in {
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/192.168.122.1";
      conf-dir = dnsmasq-dir;
    };
  };

  environment.persistence."/persist".directories = [dnsmasq-dir];
}
