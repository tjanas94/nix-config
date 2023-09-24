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
  node18 = mkShell {
    nativeBuildInputs = [ nodejs-slim-18_x nodejs-18_x.pkgs.npm ];
  };
}
