{
  inputs,
  pkgs,
}: {
  filetype-nvim = pkgs.callPackage ./filetype-nvim.nix {inherit inputs;};
  polyword-vim = pkgs.callPackage ./polyword-vim.nix {inherit inputs;};
}
