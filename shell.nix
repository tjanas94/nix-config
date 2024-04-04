{ pkgs, outputs }: with pkgs; {
  default =
    let
      installPreCommit = outputs.checks.${pkgs.system}.pre-commit-check.shellHook;
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
        pinentry-curses
        sops
        ssh-to-age
      ];
    };
  node20 = mkShell {
    nativeBuildInputs = [ nodejs-slim_20 nodejs_20.pkgs.npm ];
  };
}
