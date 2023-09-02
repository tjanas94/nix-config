let
  dnsmasq-dir = "/etc/dnsmasq.d";
in
{
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/192.168.122.1";
      bind-interfaces = true;
      conf-dir = dnsmasq-dir;
      interface = "lo";
    };
  };

  environment.persistence."/persist".directories = [ dnsmasq-dir ];
}
