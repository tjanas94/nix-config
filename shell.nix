{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [git gnupg nix pinentry-curses];
  };
  node14 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-14_x nodejs-14_x.pkgs.npm];
  };
  node18 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-18_x nodejs-18_x.pkgs.npm];
  };
}
