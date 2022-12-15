{
  lib,
  pkgs,
  ...
}: {
  programs = {
    fish.shellInit = lib.mkOrder 200 ''
      source ${pkgs.fzf}/share/fzf/key-bindings.fish && fzf_key_bindings
    '';
    fzf.enableFishIntegration = false;
  };
}
