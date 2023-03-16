{
  lib,
  pkgs,
  ...
}: let
  dnsmasq-dir = "/etc/dnsmasq.d";
in {
  virtualisation = {
    docker.enable = true;

    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/192.168.122.1";
      conf-dir = dnsmasq-dir;
    };
  };

  system = {
    nssModules = [pkgs.libvirt];
    nssDatabases.hosts = lib.mkBefore ["libvirt" "libvirt_guest"];
  };

  environment.persistence."/persist" = {
    directories = ["/var/lib/libvirt" dnsmasq-dir];
  };
}
