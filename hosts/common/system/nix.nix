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
      trusted-users = [ "root" "@wheel" ];
      experimental-features = "nix-command flakes repl-flake";
      auto-optimise-store = true;
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs;

    nixPath =
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
        config.nix.registry;
  };
}
