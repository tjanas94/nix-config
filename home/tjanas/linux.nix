{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [./common];

  targets.genericLinux.enable = true;

  nix = {
    enable = true;
    package = pkgs.nix;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs;
  };

  services.screen-locker.lockCmd = lib.mkForce "/usr/bin/i3lock -nec000000";
  xsession.windowManager.command =
    lib.mkForce
    "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${config.xsession.windowManager.herbstluftwm.package}/bin/herbstluftwm --locked";
}
