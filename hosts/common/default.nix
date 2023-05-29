{outputs, ...}: {
  imports =
    [
      ./boot/btrfs.nix
      ./boot/grub.nix
      ./boot/luks.nix
      ./boot/network.nix
      ./boot/swap.nix
      ./home-manager.nix
      ./persistence.nix
      ./programs/fish.nix
      ./programs/global.nix
      ./services/avahi.nix
      ./services/openssh.nix
      ./sops.nix
      ./system/locale.nix
      ./system/network.nix
      ./system/nix.nix
      ./users/tjanas
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
