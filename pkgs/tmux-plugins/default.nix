{
  inputs,
  pkgs,
}: {
  tmux-gruvbox-truecolor = pkgs.callPackage ./tmux-gruvbox-truecolor.nix {inherit inputs;};
}
