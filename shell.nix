{ lib, pkgs, outputs }: with pkgs; {
  default =
    let
      installPreCommit = outputs.checks.${system}.pre-commit-check.shellHook;
    in
    mkShell {
      shellHook = ''
        source nixconfig.sh
        ${installPreCommit}
      '';
      nativeBuildInputs = [
        age
        git
        gnupg
        nix
        nixd
        nixpkgs-fmt
        node2nix
        pinentry-curses
        sops
        ssh-to-age
      ];
    };
  node20 = mkShell {
    nativeBuildInputs = [ nodejs-slim_20 nodejs_20.pkgs.npm nodejs_20.pkgs.node-gyp bun ];
    LD_LIBRARY_PATH = lib.makeLibraryPath [ stdenv.cc.cc ];
  };
}
