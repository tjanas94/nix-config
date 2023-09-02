{ lib
, pkgs
, ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
  };

  system = {
    nssModules = [ pkgs.libvirt ];
    nssDatabases.hosts = lib.mkBefore [ "libvirt" "libvirt_guest" ];
  };

  environment.persistence."/persist".directories = [ "/var/lib/libvirt" ];
}
