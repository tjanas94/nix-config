{ config
, inputs
, lib
, outputs
, ...
}: {
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "@wheel" ];
      experimental-features = "nix-command flakes repl-flake";
      accept-flake-config = true;
      auto-optimise-store = true;
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs;

    nixPath =
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
        config.nix.registry;
  };
}
