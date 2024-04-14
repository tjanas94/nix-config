{ pkgs, ... }: {
  imports = [
    ./common
    ./common/hardware/bluetooth.nix
    ./common/hardware/printer.nix
    ./common/programs/dnsmasq.nix
    ./common/programs/docker.nix
    ./common/programs/i3lock.nix
    ./common/programs/k3s.nix
    ./common/programs/libvirt.nix
    ./common/programs/lightdm.nix
    ./common/programs/pipewire.nix
    ./common/programs/xserver.nix
  ];

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "net.ipv4.ip_unprivileged_port_start" = 0;
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  home-manager.users.tjanas = import ../home/tjanas/workstation.nix;
  location.provider = "geoclue2";

  networking.networkmanager.unmanaged = [
    "type:wireguard"
  ];

  programs = {
    dconf.enable = true;
    light.enable = true;
    steam.enable = true;
    wireshark.enable = true;
  };

  services = {
    gvfs.enable = true;
    pcscd.enable = true;
    trezord.enable = true;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  environment.systemPackages = with pkgs; [
    pcscliteWithPolkit.out
    wireguard-tools
  ];
}
