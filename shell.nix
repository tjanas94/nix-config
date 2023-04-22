# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [nix home-manager git];
  };
  node14 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-14_x nodejs-14_x.pkgs.npm];
  };
  node18 = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [nodejs-slim-18_x nodejs-18_x.pkgs.npm];
  };
}
