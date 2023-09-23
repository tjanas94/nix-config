{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes repl-flake";
    nativeBuildInputs = with pkgs; [ age git gnupg jq nix pinentry-curses sops ssh-to-age ];
  };
  node18 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ nodejs-slim-18_x nodejs-18_x.pkgs.npm ];
  };
}
