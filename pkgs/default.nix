{ pkgs ? (import ../nixpkgs.nix) { } }: {
  install-system = pkgs.callPackage ./install-system { };
}
