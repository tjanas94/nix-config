{ pkgs }: with pkgs; {
  graphiql = callPackage ./graphiql.nix { };
  install-system = callPackage ./install-system { };
}
