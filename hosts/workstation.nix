{
  imports = [
    ./common
    ./common/hardware/audio.nix
    ./common/hardware/bluetooth.nix
    ./common/hardware/printer.nix
    ./common/programs/dnsmasq.nix
    ./common/programs/docker.nix
    ./common/programs/i3lock.nix
    ./common/programs/libvirt.nix
    ./common/programs/lightdm.nix
    ./common/programs/xserver.nix
  ];

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  home-manager.users.tjanas = import ../home/tjanas/workstation.nix;
  location.provider = "geoclue2";

  programs = {
    steam.enable = true;
    wireshark.enable = true;
  };

  services = {
    pcscd.enable = true;
    redshift.enable = true;
    trezord.enable = true;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
