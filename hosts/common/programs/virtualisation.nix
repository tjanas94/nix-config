{ lib
, pkgs
, ...
}: {
  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
    };
    libvirtd = {
      enable = true;
      qemu.runAsRoot = false;
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system = {
    nssModules = [ pkgs.libvirt ];
    nssDatabases.hosts = lib.mkBefore [ "libvirt" "libvirt_guest" ];
  };

  environment.persistence."/persist".directories = [
    "/var/lib/containers"
    "/var/lib/docker"
    "/var/lib/libvirt"
  ];
}
