{ pkgs, outputs }: with pkgs; {
  default = mkShell {
    inherit (outputs.checks.${pkgs.system}.pre-commit-check) shellHook;
    NIX_CONFIG = "experimental-features = nix-command flakes repl-flake";
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
