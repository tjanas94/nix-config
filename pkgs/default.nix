{ pkgs }: with pkgs; {
  install-system = callPackage ./install-system { };
}
