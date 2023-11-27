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
        nixpkgs-fmt
        pinentry-curses
        rnix-lsp
        sops
        ssh-to-age
      ];
    };
  node20 = mkShell {
    nativeBuildInputs = [ nodejs-slim_20 nodejs_20.pkgs.npm ];
  };
}
