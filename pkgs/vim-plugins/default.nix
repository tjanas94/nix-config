{
  inputs,
  pkgs,
}: {
  polyword-vim = pkgs.callPackage ./polyword-vim.nix {inherit inputs;};
}
