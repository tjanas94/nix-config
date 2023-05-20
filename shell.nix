{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [age git gnupg nix pinentry-curses sops ssh-to-age];
  };
  node14 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-14_x nodejs-14_x.pkgs.npm];
  };
  node18 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-18_x nodejs-18_x.pkgs.npm];
  };
}
