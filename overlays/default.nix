{ inputs, ... }: {
  additions = pkgs: _: import ../pkgs { inherit pkgs; };

  modifications = final: prev: {
    nodePackages = prev.nodePackages // final.callPackage ../pkgs/node-packages { };
  };

  unstable-packages = final: _prev: {
    nixpkgs-unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = inputs.emacs-overlay.overlays.default;
  nixd = inputs.nixd.overlays.default;
  neovim-nightly = inputs.neovim-nightly-overlay.overlays.default;
}
